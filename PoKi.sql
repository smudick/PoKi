--1. What grades are stored in the database?

select * from Grade

--2. What emotions may be associated with a poem?

select * from Emotion

--3. How many poems are in the database?

select count(*) as TotalPoems
from Poem

--4. Sort authors alphabetically by name. What are the names of the top 76 authors?

select top 76 a.Name
	from Author a
	order by a.Name 

--5. Starting with the above query, add the grade of each of the authors.

select top 76 a.Name, g.Name
	from Author a
	join Grade g 
		on g.Id = a.GradeId
	order by a.Name 

--6. Starting with the above query, add the recorded gender of each of the authors.

select top 76 a.Name, g.Name, gn.Name
	from Author a
	join Grade g 
		on g.Id = a.GradeId
	join Gender gn
		on gn.Id = a.GradeId
	order by a.Name 

--7. What is the total number of words in all poems in the database?

select sum(p.WordCount) as totalWords
from Poem p

--8. Which poem has the fewest characters?

select top 1 p.Title
from Poem p
order by p.CharCount

--9. How many authors are in the third grade?

select g.Name, count(*) as TotalAuthors
from Author a
join Grade g
	on a.GradeId = g.Id
where g.Name = '3rd Grade'
group by g.Name

--10. How many authors are in the first, second or third grades?

select count(*) as AuthorsInFirstSecondOrThirdGrade
from Author a
join Grade g
	on a.GradeId = g.Id
where g.Name = '3rd Grade' 
	or g.Name = '2nd Grade'
	or g.Name = '1st Grade'

--11. What is the total number of poems written by fourth graders?

select g.Name, count(*) as TotalPoems
from poem p
	join Author a 
	on a.Id = p.AuthorId
	join Grade g
	on g.id = a.GradeId
where g.Name = '4th Grade'
group by g.Name

--12. How many poems are there per grade?

select g.Name, count(*) as TotalPoems
from poem p
	join Author a 
	on a.Id = p.AuthorId
	join Grade g
	on g.id = a.GradeId
group by g.Name

--13. How many authors are in each grade? (Order your results by grade starting with `1st Grade`)

select g.Name, count(*) as TotalAuthors
from Author a
join Grade g
	on a.GradeId = g.Id
group by g.Name
order by g.Name

--14. What is the title of the poem that has the most words?

select top 1 p.Title, p.WordCount
from poem p
order by p.WordCount desc

--15. Which author(s) have the most poems? (Remember authors can have the same name.)

select top 10 a.Id, a.name, count(p.Title) as totalPoems
from Author a
	join Poem p 
		on a.Id = p.AuthorId
	group by a.Id, a.Name
	order by totalPoems desc

--16. How many poems have an emotion of sadness?

select e.Name, count(*) as TotalPoems
from Poem p
	join PoemEmotion pe
	on pe.PoemId = p.Id
	join Emotion e
	on pe.EmotionId = e.id
	where e.Name = 'sadness'
	group by e.Name

--17. How many poems are not associated with any emotion?

select count(*) as TotalPoemsWithNoEmotions 
from poem p
	left join PoemEmotion pe
	on p.id = pe.PoemId
	where pe.Id is null
	group by pe.Id

--18. Which emotion is associated with the least number of poems?

select e.Name, count(*) as TotalPoems
from poem p
	join PoemEmotion pe
	on p.id = pe.PoemId
	join Emotion e 
	on e.id = pe.EmotionId
	group by e.Name
	order by TotalPoems		

--19. Which grade has the largest number of poems with an emotion of joy?

select g.Name, count(*) as TotalJoyfulPoems 
from poem p
	join PoemEmotion pe
	on pe.PoemId = p.Id
	join Emotion e
	on e.Id = pe.EmotionId
	join Author a
	on a.Id = p.AuthorId
	join Grade g
	on g.id = a.GradeId
	where e.Name = 'joy'
	group by g.Name
	order by TotalJoyfulPoems desc

--20. Which gender has the least number of poems with an emotion of fear?

select g.Name, count(*) as TotalFearfulPoems 
from poem p
	join PoemEmotion pe
	on pe.PoemId = p.Id
	join Emotion e
	on e.Id = pe.EmotionId
	join Author a
	on a.Id = p.AuthorId
	join Gender g
	on g.id = a.GradeId
	where e.Name = 'Fear'
	group by g.Name
	order by TotalFearfulPoems