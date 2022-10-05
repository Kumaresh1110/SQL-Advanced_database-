(i)Select query to find the total feeding time for all of the rare animals.
	
	Select Sum(TimeToFeed) as  total_feeding_time from Animal group by acategory having acategory ='rare';

(ii)Select query to find the animal which have a `time to feed' larger than every rare animal? Give the id and name of the animal.

	Select AID,Aname from Animal A1 where timetofeed >(Select max(timetofeed) from Animal A2 where Acategory='rare');

(iii)Select query to find the name of zookeepers handling at least 4 animals.

	SELECT Z.ZID, Z.ZName, COUNT(H.AnimalID) "Animal_count" FROM Handles H INNER JOIN ZooKeeper Z ON H.ZooKeepID = Z.ZID GROUP BY Z.ZID, Z.ZName HAVING COUNT(H.AnimalID) >= 4;

(iv)Select query to find the names of the animals that are not related to the bear.

	SELECT AName FROM Animal  WHERE AName NOT LIKE '%bear%';

(v)Select query to find the zookeepers earning the most while feeding animals.

	SELECT Z.ZID, Z.ZName , SUM(Z.HourlyRate * A.TimeToFeed) AS Total_Rate FROM Handles H      
	INNER JOIN ZooKeeper Z   
	ON H.ZooKeepID = Z.ZID     
	INNER JOIN Animal A       
	ON H.AnimalID = A.AID    
	GROUP BY Z.ZID, Z.ZName   
	HAVING SUM(Z.HourlyRate * A.TimeToFeed) =   
	(SELECT MAX(T.Total_Rate)
	FROM (SELECT Z.ZID, SUM(Z.HourlyRate * A.TimeToFeed) AS Total_Rate   
	FROM Handles H           
	INNER JOIN ZooKeeper Z   
	ON H.ZooKeepID = Z.ZID    
	INNER JOIN Animal A       
	ON H.AnimalID = A.AID     
	GROUP BY Z.ZID) T);


