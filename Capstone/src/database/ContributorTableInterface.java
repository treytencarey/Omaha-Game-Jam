package database;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

// Used to interface with the Contributor table
public class ContributorTableInterface implements Serializable{

	private static final long serialVersionUID = 1L;
	private ArrayList<Contributor> contributors = new ArrayList<Contributor>();
	
	public ContributorTableInterface(int GamePKey)
	{
		List<Map<String, Object>> query = Database.executeQuery("SELECT * FROM Contributors WHERE GamePKey=" + String.valueOf(GamePKey));
//		if (query.size() == 0)
//			throw new NullPointerException();
		//query looks like: [{AccountPKey=4, GamePKey=1, RolePKey=1}, {AccountPKey=3, GamePKey=1, RolePKey=5}]
        java.util.ListIterator<Map<String, Object>> litr = query.listIterator();
        while(litr.hasNext())
        {
        	Map<String, Object> temp = litr.next();
        	String a = temp.get("AccountPKey").toString();
        	String g = temp.get("GamePKey").toString();
        	String r = temp.get("RolePKey").toString();
        	contributors.add(new Contributor(a, g, r));
        }
	}
	
	public ArrayList<Contributor> getContributors(){
		return contributors;
	}
	public void setContributors(ArrayList<Contributor> contributors) {
		this.contributors = contributors;
	}

}