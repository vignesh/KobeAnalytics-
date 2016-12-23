--File dsiplays queries and query results of a csv file containing stats Kobe's 20 year long career (provided by Kaggle.com)

--number of shots Kobe has taken
SELECT COUNT(id) FROM public.kobe;
 /*count 
-------
 30697*/

---Average shot distance 
SELECT ROUND(AVG(shotdistance)) FROM public.kobe;
/* round 
-------
    13*/

--Longest shot distance 
SELECT MAX(shotdistance) FROM public.kobe;
/* max 
-----
  79*/

--Number of 2 point field goals attempted, ordered by minutes left in the quarter
SELECT minleft,COUNT(shotvalue) FROM public.kobe WHERE shotvalue LIKE '2PT%' GROUP BY minleft ORDER BY minleft asc;
 /*minleft | count 
---------+-------
       0 |  2508
       1 |  2104
       2 |  2250
       3 |  2265
       4 |  2273
       5 |  2111
       6 |  1923
       7 |  1848
       8 |  1772
       9 |  1857
      10 |  1791
      11 |  1569*/

--Number of 3 point field goals attempted, ordered by minutes left in the quarter
 SELECT minleft,COUNT(shotvalue) FROM public.kobe WHERE shotvalue LIKE '3PT%' GROUP BY minleft ORDER BY minleft asc;
 /* minleft | count 
---------+-------
       0 |  1358
       1 |   630
       2 |   584
       3 |   574
       4 |   582
       5 |   540
       6 |   460
       7 |   367
       8 |   367
       9 |   345
      10 |   331
      11 |   288*/

--Number of 2 point field goals attempted, sorted and ordered by period
SELECT period,COUNT(shotvalue) FROM public.kobe WHERE shotvalue LIKE '2PT%' AND (shotflag = 0 OR shotflag = 1) GROUP BY period ORDER BY period asc;
/*period | count 
--------+-------
      1 |  5584
      2 |  4482
      3 |  5563
      4 |  4405
      5 |   224
      6 |    22
      7 |     5*/


--Number of 2 point field goals made, sorted and ordered by period
SELECT period,COUNT(shotvalue) FROM public.kobe WHERE shotvalue LIKE '2PT%' AND  shotflag = 1 GROUP BY period ORDER BY period asc;
/* period | count 
--------+-------
      1 |  2738
      2 |  2144
      3 |  2678
      4 |  2001
      5 |   111
      6 |     9
      7 |     2*/

--Number of 3 point field goals attempted, sorted and ordered by period
SELECT period,COUNT(shotvalue) FROM public.kobe WHERE shotvalue LIKE '3PT%' AND (shotflag = 0 OR shotflag = 1) GROUP BY period ORDER BY period asc;
/*period | count 
--------+-------
      1 |  1116
      2 |  1153
      3 |  1439
      4 |  1638
      5 |    56
      6 |     8
      7 |     2*/

--Number of 3 point field goals made, sorted and ordered by period
 SELECT period,COUNT(shotvalue) FROM public.kobe WHERE shotvalue LIKE '3PT%' AND  shotflag = 1 GROUP BY period ORDER BY period asc;
/* period | count 
--------+-------
      1 |   382
      2 |   385
      3 |   497
      4 |   499
      5 |    13
      6 |     5
      7 |     1*/

--Type of shots Kobe attempts, order by shot type
SELECT shottype, COUNT(shottype) AS count FROM public.kobe GROUP BY shottype ORDER BY count desc;
/*shottype  | count 
-----------+-------
 Jump Shot | 23485
 Layup     |  5448
 Dunk      |  1286
 Tip Shot  |   184
 Hook Shot |   153
 Bank Shot |   141*/


--Number of shots Kobe has attempted with less than 5 seconds in the foruth quarter
SELECT secondsleft, COUNT(secondsleft) FROM public.kobe WHERE period = 4 AND secondsleft < 5 GROUP BY secondsleft ORDER by COUNT(secondsleft) desc;
/*secondsleft | count 
-------------+-------
           0 |   182
           2 |   144
           1 |   125
           4 |   121
           3 |   115*/

 --Overall career shooting percentage
 SELECT (SELECT COUNT(shotflag) FROM public.kobe WHERE shotflag = 1)/(SELECT COUNT(shotflag) FROM public.kobe WHERE (shotflag = 1 OR shotflag = 0))::float AS careershooting;
   /*careershooting   
-------------------
 0.446161030470483*/

 --Overall 4th quarter shooting percentage
 SELECT (SELECT COUNT(shotflag) FROM public.kobe WHERE shotflag = 1 AND period = 4)/(SELECT COUNT(shotflag) FROM public.kobe WHERE (shotflag = 1 OR shotflag = 0) AND period = 4)::float AS fourthshooting;
 /* fourthshooting   
-------------------
 0.413701803739864*/

 --Overall 4th quarter last minute shooting
 SELECT (SELECT COUNT(shotflag) FROM public.kobe WHERE shotflag = 1 AND period = 4 AND minleft <= 1)/(SELECT COUNT(shotflag) FROM public.kobe WHERE (shotflag = 1 OR shotflag = 0) AND period = 4 AND minleft <= 1)::float AS minuteshooting;;
   /*minuteshooting   
-------------------
 0.384668989547038*/

--Buzzer beater shooting percentage 
SELECT (SELECT COUNT(shotflag) FROM public.kobe WHERE period = 4 AND secondsleft = 0 AND shotflag = 1)/(SELECT COUNT(shotflag) FROM public.kobe WHERE period = 4 AND secondsleft = 0 AND (shotflag =1 OR shotflag =0))::float AS buzzerbeater;
 /*   buzzerbeater    
-------------------
 0.331034482758621*/

 --Season shooting percentage
 SELECT (SELECT COUNT(shotflag) FROM public.kobe WHERE playoffs = 0 AND shotflag = 1)/(SELECT COUNT(shotflag) FROM public.kobe WHERE playoffs = 0 AND (shotflag = 0 OR shotflag = 1))::float AS seasonpercentage;
 /* seasonpercentage  
-------------------
 0.446419618031816*/

 --Playoffs shooting percentage
 SELECT (SELECT COUNT(shotflag) FROM public.kobe WHERE playoffs = 1 AND shotflag = 1)/(SELECT COUNT(shotflag) FROM public.kobe WHERE playoffs = 1 AND (shotflag = 0 OR shotflag = 1))::float AS playoffspercentage;
 /* playoffspercentage 
--------------------
  0.444651410324641*/

  --Number of shots made in a season, sorted by total shots made
  SELECT season, COUNT(shotflag) AS shotsmade FROM public.kobe WHERE shotflag = 1 GROUP BY season ORDER BY shotsmade desc;
   /*season  | shotsmade 
---------+-----------
 2005-06 |       873
 2008-09 |       866
 2007-08 |       852
 2002-03 |       808
 2009-10 |       804
 2001-02 |       783
 2000-01 |       735
 2006-07 |       723
 2010-11 |       679
 2012-13 |       608
 1999-00 |       604
 2011-12 |       603
 2003-04 |       594
 2004-05 |       492
 1998-99 |       351
 1997-98 |       349
 2015-16 |       332
 2014-15 |       223
 1996-97 |       162
 2013-14 |        24*/

--Most shots made against a team, ordered by shots made
SELECT opponent, COUNT(shotflag) AS shotsmade FROM public.kobe WHERE shotflag = 1 GROUP BY opponent ORDER BY shotsmade desc;
/*opponent | shotsmade 
----------+-----------
 SAS      |       715
 PHX      |       713
 SAC      |       650
 DEN      |       619
 HOU      |       608
 POR      |       601
 UTA      |       550
 MIN      |       542
 GSW      |       531
 LAC      |       495
 DAL      |       469
 MEM      |       392
 BOS      |       322
 SEA      |       314
 PHI      |       271
 NYK      |       270
 ORL      |       263
 DET      |       259
 TOR      |       258
 IND      |       251
 OKC      |       235
 CLE      |       226
 CHI      |       222
 MIA      |       222
 CHA      |       218
 WAS      |       214
 NOH      |       214
 MIL      |       208
 ATL      |       198
 NJN      |       184
 NOP      |       117
 VAN      |        96
 BKN      |        18*/

--Most shots missed against a team, ordered by shots made
SELECT opponent, COUNT(shotflag) AS shotsmade FROM public.kobe WHERE shotflag = 0 GROUP BY opponent ORDER BY shotsmade desc;
/* opponent | shotsmade 
----------+-----------
 SAS      |       923
 PHX      |       822
 HOU      |       791
 SAC      |       747
 DEN      |       733
 POR      |       691
 UTA      |       688
 MIN      |       677
 GSW      |       612
 LAC      |       579
 DAL      |       564
 MEM      |       479
 BOS      |       461
 SEA      |       380
 IND      |       375
 ORL      |       341
 PHI      |       332
 DET      |       328
 OKC      |       326
 MIL      |       299
 TOR      |       298
 NYK      |       296
 MIA      |       295
 CHI      |       294
 CLE      |       288
 WAS      |       287
 CHA      |       282
 NOH      |       261
 ATL      |       240
 NJN      |       238
 NOP      |       170
 VAN      |       108
 BKN      |        27*/

 --Top 5 distances in which Kobe has made the most shots from 
 SELECT shotdistance, COUNT(shotflag) AS shotsmade FROM public.kobe WHERE shotflag = 1 GROUP BY shotdistance ORDER BY shotsmade desc LIMIT 5;
 /* shotdistance | shotsmade 
--------------+-----------
            0 |      2925
           25 |       583
           18 |       479
           17 |       477
           19 |       471*/

 --Favorite shooting area ordered by number of shots made
 SELECT shotzone, COUNT(shotflag) AS shotsmade FROM public.kobe WHERE shotflag = 1 GROUP BY shotzone ORDER BY shotsmade desc;
        /*shotzone        | shotsmade 
-----------------------+-----------
 Center(C)             |      5933
 Right Side(R)         |      1550
 Right Side Center(RC) |      1523
 Left Side(L)          |      1243
 Left Side Center(LC)  |      1215
 Back Court(BC)        |         1*/

 --Favorite shooting spors ordered by number of shots made
 SELECT shotzonebase, COUNT(shotflag) AS shotsmade FROM public.kobe WHERE shotflag = 1 GROUP BY shotzonebase ORDER BY shotsmade desc;
 /*     shotzonebase      | shotsmade 
-----------------------+-----------
 Mid-Range             |      4279
 Restricted Area       |      3666
 In The Paint (Non-RA) |      1763
 Above the Break 3     |      1554
 Right Corner 3        |       113
 Left Corner 3         |        89
 Backcourt             |         1*/

--Lowest scoring game, grouped by date
SELECT gamedate,  COUNT(shotflag) AS shotsmade FROM public.kobe WHERE shotflag = 1 GROUP BY gamedate ORDER BY shotsmade asc LIMIT 1;
  /*gamedate  | shotsmade 
------------+-----------
 1996-11-15 |         1*/

 --Highest scoring game, grouped by date
 SELECT gamedate,  COUNT(shotflag) AS shotsmade FROM public.kobe WHERE shotflag = 1 GROUP BY gamedate ORDER BY shotsmade desc LIMIT 1;
 /* gamedate  | shotsmade 
------------+-----------
 2006-01-22 |        22*/
