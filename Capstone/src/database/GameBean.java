package database;

import java.io.IOException;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

<<<<<<< HEAD:Capstone/src/database/Game.java
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/gameServlet")
public class Game extends HttpServlet implements Serializable{

	private static final long serialVersionUID = 1L;
	
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
	private List<Integer> mutators=new ArrayList<Integer>();
	/**
	 * A list of systems for the game by primary key.
	 */
	private List<Integer> systems=new ArrayList<Integer>();
	/**
	 * Whether or not the game is public.
	 */
	private Boolean isPublic;
	/**
	 * A reference to the submitter account primary key.
	 */
	private Integer submitter;
	/**
	 * A reference to the event primary key.
	 */
	private Integer event;
	
	/**
	 * Handles form submissions for the gameServlet.
	 * @param request the servlet request.
	 * @param response the servlet for response.
	 */
	protected void doPost(HttpServletRequest request,
            HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession(false);
		
		boolean updatingGame = request.getParameter("updateGameButton") != null;
		if (updatingGame)
		{
			// parse mutators
			List<Integer> mutators=new ArrayList<Integer>();
			// parse systems
			List<Integer> systems=new ArrayList<Integer>();
			new Game(Integer.parseInt(session.getAttribute("accountPKey").toString()), 1, request.getParameter("title").toString(), request.getParameter("description").toString(), mutators, systems, true).updateGame(request.getParameter("PKey") != null ? Integer.parseInt(request.getParameter("PKey").toString()) : -1);
			
			response.sendRedirect(session.getAttribute("curPage").toString());
			return;
		}
		updatingGame = request.getParameter("gameSubmitAfterFiles") != null;
		if (updatingGame)
		{
			Map<String, String> params = Files.getLastPostParams(session);
			
			// parse mutators
			List<Integer> mutators=new ArrayList<Integer>();
			// parse systems
			List<Integer> systems=new ArrayList<Integer>();
			new Game(Integer.parseInt(session.getAttribute("accountPKey").toString()), 1, params.get("title"), params.get("description"), mutators, systems, true).updateGame(params.get("PKey") != null ? Integer.parseInt(params.get("PKey").toString()) : -1);
			
			response.sendRedirect(session.getAttribute("curPage").toString());
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
	public Game(Integer submitter, Integer event, String title, String desc, List<Integer> muators, List<Integer> systems, Boolean isPublic)
	{
		this.setSubmitter(submitter);
		this.setEvent(event);
		this.setTitle(title);
		this.setDesc(desc);
		this.setMutators(muators);
		this.setSystems(systems);
		this.setIsPublic(isPublic);
	}
	
	/**
	 * Gets a blank game.
	 */
	public Game()
=======
/**
 * Model for the DB's Games table, used to retrieve a single row when given a Game's ID.
 */
public class GameBean implements Serializable{

	private static final long serialVersionUID = 1L;
	private String id, event, submitter, title, desc, link, isPublic;
	
	/**
	 * Instantiate a new GameBean with blank fields.
	 * This does not interact with the DB in any way.
	 */
	public GameBean()
>>>>>>> 1885a384342e03e43eec99afd8d8ee32738680a4:Capstone/src/database/GameBean.java
	{
		
	}
	
	/**
<<<<<<< HEAD:Capstone/src/database/Game.java
	 * Gets a game from the database.
	 * @param PKey an integer value of the game's primary key.
	 */
	public Game(int PKey)
	{
		List<Map<String, Object>> query = Database.executeQuery("SELECT * FROM Games WHERE PKey=" + String.valueOf(PKey));
=======
	 * Fetch the specified game from the DB and instantiate a GameBean with its data.
	 * @param PKey the id of the game to fetch from Games table.
	 */
	public GameBean(String PKey)
	{
		this.setId(PKey + "");
		List<Map<String, Object>> query = Database.executeQuery("SELECT * FROM Games WHERE PKey=" + this.getId());
>>>>>>> 1885a384342e03e43eec99afd8d8ee32738680a4:Capstone/src/database/GameBean.java
		if (query.size() == 0)
			throw new NullPointerException();
		Map<String, Object> game = query.get(0);
		
		this.setTitle(game.get("Title").toString());
		this.setDesc(game.get("Description").toString());
		this.setIsPublic(game.get("IsPublic").toString().equals("1"));
	}
	
	/**
	 * Updates the game in the database with the given primary key to the values of the game.
	 * @param PKey an integer value of the profile's primary key.
	 */
	private void updateGame(int PKey)
	{
		Database.executeUpdate("INSERT OR REPLACE INTO Games (" + ((PKey >= 1) ? "PKey, " : "") + "EventPKey, SubmitterPKey, Title, Description, IsPublic) VALUES (" + ((PKey >= 1) ? String.valueOf(PKey) + ", " : "") + this.toString() + ")");
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
		return String.valueOf(event) + ", " + String.valueOf(submitter) + ", '" + Database.formatString(title) + "', '" + Database.formatString(desc) + "', " + ((isPublic) ? "1" : "0");
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
	public List<Integer> getMutators() {
		return mutators;
	}
	
	/**
	 * Gets the systems of the game by primary key.
	 * @return The systems of the game by primary key.
	 */
	public List<Integer> getSystems() {
		return systems;
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
	public void setMutators(List<Integer> mutators) {
		this.mutators = mutators;
	}
	
	/**
	 * Sets the systems of the game by primary key.
	 * @param The systems of the game by primary key.
	 */
	public void setSystems(List<Integer> systems) {
		this.systems = systems;
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
}