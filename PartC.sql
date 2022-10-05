1.People to whom Brad can reach to either directly or transitively.
	
Query:
	
	With Reaches(person,friend,cnt,path) As
(Select person,friend,1,person||'.'|| friend
from SocialNetwork where Person='Brad' or friend='Brad' Union All
Select R.Person,SN.Friend,cnt+1,R.Person||'.'||path from SocialNetwork SN, Reaches R
where SN.Friend=R.Person  and path NOT LIKE '%'||R.Friend||'%')

select * from Reaches where person='Brad';

2.People in DePauledIN network to whom Brad cannot reach to.
	
Query:

	With Reaches(person,friend,cnt,path) As
(Select person,friend,1,person||'.'|| friend
from SocialNetwork where person<>'Brad' Union All
Select R.Person,SN.Friend,cnt+1,R.Person||'.'||path from SocialNetwork SN, Reaches R
where R.Friend=SN.Person AND path NOT LIKE '%'||R.friend||'%') select * from Reaches where friend<>'Brad';

3.Only those people who are connected to Christine via transitive relationship i.e not an immediate follower.

Query:

	WITH Connects(Person,friend,cnt,path) AS ( SELECT Person, Friend,1,person||'.'|| friend FROM SocialNetwork 
WHERE friend= 'Christine' and Person<>'Christine' UNION ALL
SELECT SN.Person, R.Friend,cnt+1,R.Person||'.'||path
FROM SocialNetwork SN,Connects R  
where R.Friend = SN.Person and path NOT LIKE '%'||R.friend||'%') SELECT * FROM Connects where cnt > 1; 

4.Find the shortest path to reach from Amy to James.

Query:

	WITH  Reaches (person,friend,cnt,path) AS 
(SELECT Person, Person,1,person||'.'|| friend
FROM SocialNetwork WHERE Person = 'Amy' UNION ALL
SELECT SN.Person, R.Friend,cnt+1,R.Person||'.'||path
FROM SocialNetwork SN,Reaches r where R.Friend = SN.Person and path NOT LIKE '%'||R.friend||'%')
SELECT * FROM Reaches WHERE friend = 'James' and cnt=(Select min(cnt) from reaches group by cnt);