package database;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;
import java.util.ListIterator;
import java.util.Map;

/**
 * Model for the DB's AppliedMutators table, used to retrieve 0..n rows of applied mutators for a single Game.
 */
public class MutatorTableBean implements Serializable {

	private static final long serialVersionUID = 1L;
	private ArrayList<Mutator> mutators = new ArrayList<Mutator>();
	
	/**
	 * Fetch the mutators for the specified game from the DB's AppliedMutators table and instantiate a MutatorTableBean with them.
	 * @param GamePKey the id of the game to get applied mutators for from AppliedMutators table.
	 */
	public MutatorTableBean(String GamePKey)
	{
		List<Map<String, Object>> query = Database.executeQuery("SELECT * FROM AppliedMutators WHERE GamePKey=" + GamePKey);
		ListIterator<Map<String, Object>> litr;
		//appliedQuery looks like: [{GamePKey=1, MutatorPKey=1}, {GamePKey=1, MutatorPKey=5}]
		
		if(query.size() > 0) // if game applied any mutators...
		{
			// create a query string by extracting the MutatorPKey and appending it
			ArrayList<String> mpks = new ArrayList<String>(); // for holding all MutatorPKeys that we get from the 1st query
	        litr = query.listIterator();
	        while(litr.hasNext())
	        	mpks.add(litr.next().get("MutatorPKey").toString());
	        
			query = Database.executeQuery("SELECT * FROM Mutators WHERE PKey=" + String.join(" OR ", mpks));
			if(query.size() > 0) // if there was at least 1 valid mutator...
			{
				litr = query.listIterator();
		        while(litr.hasNext()) // extract titles and descs and put into
		        {
		        	Map<String, Object> temp = litr.next();
		        	String t = temp.get("Title").toString();
		        	String d = temp.get("Description").toString();
		        	mutators.add(new Mutator(t, d));
		        }
			}
		}
	
	}
	
	// Bean getter / setter
	public ArrayList<Mutator> getMutators(){
		return mutators;
	}
	public void setMutators(ArrayList<Mutator> mutators) {
		this.mutators = mutators;
	}

}
