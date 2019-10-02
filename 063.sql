/*Please add ; after each select statement*/
CREATE PROCEDURE dancingCompetition()
BEGIN
    SELECT
      MAX(first_criterion) 
    , MAX(second_criterion) 
    , MAX(third_criterion) 
    , MIN(first_criterion) 
    , MIN(second_criterion) 
    , MIN(third_criterion) 
    INTO
    @max1, @max2, @max3, @min1, @min2, @min3
    FROM scores
    ;
    
    SELECT 
          d1.arbiter_id
        , d1.first_criterion
        , d1.second_criterion
        , d1.third_criterion
    FROM (
        SELECT 
            s.*
            , CASE WHEN s.first_criterion != @max1 THEN 0 ELSE 1 END AS max1
            , CASE WHEN s.first_criterion != @min1 THEN 0 ELSE 1 END AS min1
            , CASE WHEN s.second_criterion != @max2 THEN 0 ELSE 1 END AS max2
            , CASE WHEN s.second_criterion != @min2 THEN 0 ELSE 1 END AS min2
            , CASE WHEN s.third_criterion != @max3 THEN 0 ELSE 1 END AS max3
            , CASE WHEN s.third_criterion != @min3 THEN 0 ELSE 1 END AS min3
        FROM scores s
    ) d1
    WHERE (max1+min1+max2+min2+max3+min3) < 2
    ;
END