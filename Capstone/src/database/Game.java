package database;

import java.io.File;
import java.io.IOException;
import java.io.Serializable;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import beans.EventTableBean;
import exceptions.EmptyQueryException;
import project.Main;
import utils.Utils;

@WebServlet("/gameServlet")
public class Game extends HttpServlet implements Serializable{

	private static final long serialVersionUID = 1L;

	/**
	 * The primary key of the game.
	 */
	private Integer id=-1;
	/**
	 * The title of the game.
	 */
	private String title="";
	/**
	 * The description of the game.
	 */
	private String desc="";
	/**
	 * A list of mutators for the game by primary key.
	 */
	private List<Mutator> mutators=new ArrayList<Mutator>();
	/**
	 * A list of systems for the game by primary key.
	 */
	private List<Platform> systems=new ArrayList<Platform>();
	/**
	 * A list of tools for the game by primary key.
	 */
	private List<Tool> tools=new ArrayList<Tool>();
	/**
	 * A list of tools for the game by primary key.
	 */
	private List<Contributor> contributors=new ArrayList<Contributor>();
	/**
	 * Whether or not the game is public.
	 */
	private Boolean isPublic=true;
	/**
	 * A reference to the submitter account primary key.
	 */
	private Integer submitter=-1;
	/**
	 * A reference to the event primary key.
	 */
	private Integer event=-1;
	/**
	 * The link to play the game.
	 */
	private String link="";

	/**
	 * Handles form submissions for the gameServlet.
	 * @param request the servlet request.
	 * @param response the servlet for response.
	 */
	protected void doPost(HttpServletRequest request,
            HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession(false);

		boolean updatingGame = request.getParameter("gameSubmitAfterFiles") != null;
		if (updatingGame)
		{
			Map<String, String> params = Files.getLastPostParams(session);

			// parse mutators
			List<Mutator> mutators=new ArrayList<Mutator>();
			// parse systems
			List<Platform> systems=new ArrayList<Platform>();
			// parse tools
			List<Tool> tools=new ArrayList<Tool>();
			
			for (Entry<String, String> param : params.entrySet())
			{
				if (param.getKey().indexOf("mutatorCheck") == 0)
				{
					try
					{
						mutators.add(new Mutator(Integer.parseInt(param.getValue())));
					}
					catch (EmptyQueryException eqe) {
						// TODO: handle exception
						System.out.println(eqe.getQuery());
					}
				}
				else if (param.getKey().indexOf("platformCheck") == 0)
				{
					systems.add(new Platform(Integer.parseInt(param.getValue())));
				}
				else if (param.getKey().equals("tools"))
				{
					for (String tool : param.getValue().split(","))
						if (tool.length() > 0)
							tools.add(new Tool(Integer.parseInt(tool)));
				}
			}
			
			List<Contributor> contributors=new ArrayList<Contributor>();
			int noOfAuthors = params.get("noOfAuthors") != null ? Integer.parseInt(params.get("noOfAuthors").toString()) : 0;
			int authorI = 1;
			while (noOfAuthors >= 0)
			{
				if (params.get("author" + String.valueOf(authorI)) != null)
				{
					String authorName = params.get("author" + String.valueOf(authorI));
					String authorRole = params.get("authorRole" + String.valueOf(authorI));
					
					List<Map<String, Object>> dbAuthors;
					// Step 1. Check if exact email exists first. This is because it's possible that, especially with trolls, someone could set their name to the same email address (thus, causing an error for anyone submitting a game).
					dbAuthors = Database.executeQuery("" +
							"SELECT PKey FROM Accounts WHERE lower(Email) = lower('" + authorName + "')"
							);
					if (dbAuthors.size() == 0)
					{
						// Step 2. Check if there are any near-matches for emails or profile names. 
						dbAuthors = Database.executeQuery("" +
								"SELECT DISTINCT PKey FROM (" + 
								"	SELECT PKey FROM Accounts WHERE lower(Email) like lower('" + authorName + "%')" + 
								"	UNION" + 
								"	SELECT AccountPKey AS PKey FROM Profiles WHERE lower(Name) like lower('" + authorName + "%')" + 
								")"
								);
					}
					if (dbAuthors.size() > 1)
					{
						response.setStatus(400);
						response.getWriter().print("Couldn't determine an email or profile name for author \"" + authorName + "\". Please be more specific.");
						response.getWriter().flush();
						return;
					}
					else if (dbAuthors.size() == 0)
					{
						response.setStatus(400);
						response.getWriter().print("No emails or profile names matching author \"" + authorName + "\". Please select an existing author.");
						response.getWriter().flush();
						return;
					}

					contributors.add(new Contributor(dbAuthors.get(0).get("PKey").toString(), authorRole));
					
					noOfAuthors--;
				}
				authorI++;
				// There's gotta be some limit, right? No one would add and remove this many authors.
				if (authorI > 5000)
					break;
			}
			
			Game g = null;
			try {
				g = new Game(Integer.parseInt(session.getAttribute("accountPKey").toString()), new EventTableBean().getCurrentEvent().getKey(), params.get("title"), params.get("link"), params.get("description"), mutators, systems, tools, contributors, true);
			}
			catch (Exception e)
			{
				e.printStackTrace();
				response.setStatus(400);
				response.getWriter().print("Failed to update game.");
				response.getWriter().flush();
				return;
			}
			g.updateGame(request.getParameter("PKey") != null ? Integer.parseInt(request.getParameter("PKey").toString()) : -1);
			
			String tempPath = "/Uploads/temp/";
			for (String file : Utils.getFilesInDir(tempPath))
			{
				if (file.indexOf("gamesub_") == 0) {
					if (file.indexOf(session.getAttribute("accountPKey").toString()) == 9) {
						String newPath = file.charAt(8) == '0' ? Main.context.getRealPath("/Uploads/Games/Thumbnails/") + String.valueOf(g.getId()) : Main.context.getRealPath("/Uploads/Games/Screenshots/" + String.valueOf(g.getId()) + "/") + file.substring(9);
						new File(newPath).delete();
						if (file.charAt(8) != '0')
							java.nio.file.Files.createDirectories(Paths.get(newPath.substring(0,newPath.replace("\\","/").lastIndexOf("/"))));
						Path temp = java.nio.file.Files.move(Paths.get(Main.context.getRealPath(tempPath) + file),Paths.get(newPath));
					}
				}
			}
			
			response.setStatus(200);
			response.getWriter().print(request.getContextPath() + "/game?id=" + String.valueOf(g.getId()));
			response.getWriter().flush();
			return;
		}
		
		boolean changingPublic = request.getParameter("publicChecked") != null;
		if (changingPublic)
		{
			String PKey = request.getParameter("publicPKey");
			String checked = (request.getParameter("publicChecked").equals("1")) ? "1" : "0";
			
			Database.executeUpdate("UPDATE Games SET IsPublic='" + checked + "' WHERE PKey=" + PKey);
			
			response.sendRedirect(session.getAttribute("curPage").toString());
			return;
		}
		
		boolean changingGameSubmissionPage = request.getParameter("gameSubmissionPageNo") != null;
		if (changingGameSubmissionPage)
		{
			Integer pageNo = Integer.valueOf(request.getParameter("gameSubmissionPageNo").toString());
			
			System.out.println("SETTING PAGENO: " + String.valueOf(pageNo));
			session.setAttribute("gameSubmissionPageNo", pageNo);
			
			return;
		}
	}

	/**
	 * Gets a game based on the given values.
	 * @param title a string of the title of the game.
	 * @param desc a string of the description of the game.
	 * @param mutators a list of mutators by primary key.
	 * @param systems a list of systems by primary key.
	 * @param isPublic whether or not the game is public.
	 */
	public Game(Integer submitter, Integer event, String title, String link, String desc, List<Mutator> mutators, List<Platform> systems, List<Tool> tools, List<Contributor> contributors, Boolean isPublic)
	{
		this.setSubmitter(submitter);
		this.setEvent(event);
		this.setTitle(title);
		this.setLink(link);
		this.setDesc(desc);
		this.setMutators(mutators);
		this.setSystems(systems);
		this.setTools(tools);
		this.setContributors(contributors);
		this.setIsPublic(isPublic);
	}

	/**
	 * Gets a blank game.
	 */
	public Game()
	{

	}

	/**
	 * Gets a game from the database.
	 * @param PKey an integer value of the game's primary key.
	 */
	public Game(int PKey)
	{
		List<Map<String, Object>> query = Database.executeQuery("SELECT * FROM Games WHERE PKey=" + String.valueOf(PKey));
		if (query.size() == 0)
			throw new NullPointerException();
		Map<String, Object> game = query.get(0);

		this.setId(PKey);
		this.setSubmitter(Integer.parseInt(game.get("SubmitterPKey").toString()));
		this.setEvent(Integer.valueOf(game.get("EventPKey").toString()));
		this.setTitle(game.get("Title").toString());
		this.setLink(game.get("PlayLink").toString());
		this.setDesc(game.get("Description").toString());
		this.setIsPublic(game.get("IsPublic").toString().equals("1"));
		
		// get mutators
		query = Database.executeQuery("SELECT MutatorPKey FROM GameMutators WHERE GamePKey=" + this.getId().toString());
		List<Mutator> mutators = new ArrayList<Mutator>();
		for (Map<String, Object> row : query)
		{
			try
			{
				mutators.add(new Mutator(Integer.parseInt(row.get("MutatorPKey").toString())));
			}
			catch (EmptyQueryException eqe)
			{
				System.out.println(eqe.getQuery());
			}
		}
		this.setMutators(mutators);
		
		// get platforms
		query = Database.executeQuery("SELECT PlatformPKey FROM GamePlatforms WHERE GamePKey=" + this.getId().toString());
		List<Platform> platforms = new ArrayList<Platform>();
		for (Map<String, Object> row : query)
		{
			platforms.add(new Platform(Integer.parseInt(row.get("PlatformPKey").toString())));
		}
		this.setSystems(platforms);
		
		// get tools
		query = Database.executeQuery("SELECT ToolPKey FROM GameTools WHERE GamePKey=" + this.getId().toString());
		List<Tool> tools = new ArrayList<Tool>();
		for (Map<String, Object> row : query)
		{
			tools.add(new Tool(Integer.parseInt(row.get("ToolPKey").toString())));
		}
		this.setTools(tools);
		
		// get contributors
		query = Database.executeQuery("SELECT AccountPKey, RolePKey FROM Contributors WHERE GamePKey=" + this.getId().toString());
		List<Contributor> contributors = new ArrayList<Contributor>();
		for (Map<String, Object> row : query)
		{
			contributors.add(new Contributor(row.get("AccountPKey").toString(), this.getId().toString(), row.get("RolePKey").toString()));
		}
		this.setContributors(contributors);
	}

	/**
	 * Updates the game in the database with the given primary key to the values of the game.
	 * @param PKey an integer value of the profile's primary key.
	 */
	private void updateGame(int PKey)
	{
		Database.executeUpdate("INSERT OR REPLACE INTO Games (" + ((PKey >= 1) ? "PKey, " : "") + "EventPKey, SubmitterPKey, Title, Description, IsPublic, PlayLink) VALUES (" + ((PKey >= 1) ? String.valueOf(PKey) + ", " : "") + this.toString() + ")");
		System.out.println("INSERT OR REPLACE INTO Games (" + ((PKey >= 1) ? "PKey, " : "") + "EventPKey, SubmitterPKey, Title, Description, IsPublic, PlayLink) VALUES (" + ((PKey >= 1) ? String.valueOf(PKey) + ", " : "") + this.toString() + ")");
		if (PKey <= 0)
		{
			List<Map<String, Object>> m = Database.executeQuery("SELECT MAX(PKey) AS PKey FROM Games");
			if (m.size() > 0)
				this.setId(Integer.parseInt(m.get(0).get("PKey").toString()));
		}
		else
		{
			this.setId(PKey);
		}
		
		// Reset and add mutators
		Database.executeUpdate("DELETE FROM GameMutators WHERE GamePKey=" + this.getId().toString());
		for (Mutator mutatorPKey : this.getMutators())
		{
			Database.executeUpdate("INSERT INTO GameMutators (GamePKey, MutatorPKey) VALUES (" + this.getId().toString() + ", " + mutatorPKey.getPKey().toString() + ")");
		}
		
		// Reset and add platforms
		Database.executeUpdate("DELETE FROM GamePlatforms WHERE GamePKey=" + this.getId().toString());
		for (Platform platformPKey : this.getSystems())
		{
			Database.executeUpdate("INSERT INTO GamePlatforms (GamePKey, PlatformPKey) VALUES (" + this.getId().toString() + ", " + platformPKey.getPKey().toString() + ")");
		}
		
		// Reset and add tools
		Database.executeUpdate("DELETE FROM GameTools WHERE GamePKey=" + this.getId().toString());
		for (Tool toolPKey : this.getTools())
		{
			Database.executeUpdate("INSERT INTO GameTools (GamePKey, ToolPKey) VALUES (" + this.getId().toString() + ", " + toolPKey.getPKey().toString() + ")");
		}
		
		// Reset and add contributors
		Database.executeUpdate("DELETE FROM Contributors WHERE GamePKey=" + this.getId().toString());
		for (Contributor contributorPKey : this.getContributors())
		{
			Database.executeUpdate("INSERT INTO Contributors (AccountPKey, GamePKey, RolePKey) VALUES (" + contributorPKey.getAccountPKey() + ", " + this.getId().toString() + ", " + contributorPKey.getRolePKey().toString() + ")");
		}
	}

	/**
	 * Adds the game in the database as a new row.
	 */
	private void updateGame()
	{
		this.updateGame(-1);
	}

	/**
	 * Gets the game as a string.
	 * @return The game as a string.
	 */
	@Override
	public String toString()
	{
		return String.valueOf(event) + ", " + String.valueOf(submitter) + ", '" + Database.formatString(title) + "', '" + Database.formatString(desc) + "', " + ((isPublic) ? "1" : "0") + ", '" + Database.formatString(link) + "'";
	}
	
	/**
	 * Gets the primary key of the game.
	 * @return The primary key of the game.
	 */
	public Integer getId() {
		return id;
	}

	/**
	 * Gets the title of the game.
	 * @return The title of the game.
	 */
	public String getTitle() {
		return title;
	}

	/**
	 * Gets the description of the game.
	 * @return The description of the game.
	 */
	public String getDesc() {
		return desc;
	}

	/**
	 * Gets the mutators of the game by primary key.
	 * @return The mutators of the game by primary key.
	 */
	public List<Mutator> getMutators() {
		return mutators;
	}

	/**
	 * Gets the systems of the game by primary key.
	 * @return The systems of the game by primary key.
	 */
	public List<Platform> getSystems() {
		return systems;
	}
	
	/**
	 * Gets the tools of the game by primary key.
	 * @return The tools of the game by primary key.
	 */
	public List<Tool> getTools() {
		return tools;
	}
	
	/**
	 * Gets the contributors of the game by primary key.
	 * @return The contributors of the game by primary key.
	 */
	public List<Contributor> getContributors() {
		return contributors;
	}

	/**
	 * Gets whether or not the game is public.
	 * @return Whether or not the game is public.
	 */
	public Boolean getIsPublic() {
		return isPublic;
	}

	/**
	 * Gets the submitter of the game by primary key.
	 * @return The submitter of the game by primary key.
	 */
	public Integer getSubmitter() {
		return submitter;
	}

	/**
	 * Gets the event of the game by primary key.
	 * @return The event of the game by primary key.
	 */
	public Integer getEvent() {
		return event;
	}
	
	/**
	 * Gets the play link of the game.
	 * @return The play link of the game.
	 */
	public String getLink() {
		return link;
	}
	
	/**
	 * Sets the primary key of the game.
	 * @param The primary key of the game.
	 */
	public void setId(Integer id) {
		this.id = id;
	}

	/**
	 * Sets the title of the game.
	 * @param The title of the game.
	 */
	public void setTitle(String title) {
		this.title = title;
	}

	/**
	 * Sets the description of the game.
	 * @param The description of the game.
	 */
	public void setDesc(String desc) {
		this.desc = desc;
	}

	/**
	 * Sets the mutators of the game by primary key.
	 * @param The mutators of the game by primary key.
	 */
	public void setMutators(List<Mutator> mutators) {
		this.mutators = mutators;
	}

	/**
	 * Sets the systems of the game by primary key.
	 * @param The systems of the game by primary key.
	 */
	public void setSystems(List<Platform> systems) {
		this.systems = systems;
	}
	
	/**
	 * Sets the tools of the game by primary key.
	 * @param The tools of the game by primary key.
	 */
	public void setTools(List<Tool> tools) {
		this.tools = tools;
	}
	
	/**
	 * Sets the contributors of the game by primary key.
	 * @param The contributors of the game by primary key.
	 */
	public void setContributors(List<Contributor> contributors) {
		// It's possible that contributors were created before the game, but get set after game creation.
		for (Contributor contributor : contributors)
			contributor.setGamePKey(this.getId().toString());
		this.contributors = contributors;
	}

	/**
	 * Sets whether or not the game is public.
	 * @param Whether or not the game is public.
	 */
	public void setIsPublic(Boolean isPublic) {
		this.isPublic = isPublic;
	}

	/**
	 * Sets the submitter of the game by primary key.
	 * @param The submitter of the game by primary key.
	 */
	public void setSubmitter(Integer submitter) {
		this.submitter = submitter;
	}

	/**
	 * Sets the event of the game by primary key.
	 * @param The event of the game by primary key.
	 */
	public void setEvent(Integer event) {
		this.event = event;
	}
	
	/**
	 * Sets the play link of the game.
	 * @param The play link of the game.
	 */
	public void setLink(String link) {
		this.link = link;
	}
}
