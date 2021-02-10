--2.7
select e.empno,
       e.ename,
       case
         when e.sal >= 1000 and e.sal <= 2000 then
          1
         else
          2
       end  as levelc,
       e.sal
  from emp e order by levelc asc , e.sal asc ;

-- 2.7 写法2
select e.empno,
       e.ename,
       e.sal
  from emp e order by case
 when e.sal >= 1000 and e.sal <= 2000 then 1 else 2 end asc, e.sal asc;
 
 -- 
 DROP TABLE emp2 PURGE;
 Create Table emp2 AS 
 select ename , job , sal ,comm from emp where job = 'CLERK'
 
 explain Plan for select e.* from emp e where e.ename in( select ename from emp2);
 --select e.* from emp e where e.ename exists ( select ename from emp2);
 select * from table(dbms_xplan.display)
 -- 3.13
 select e.ename,e.comm from emp e where coalesce(e.comm,0) < (select comm from emp where ename='ALLEN');
  -- TODO
 update emp set deptno = null where empno = 7788;commit;
 select d.* from dept d where d.deptno not in (select deptno from emp where deptno is not null);
 
 --6.2
 select e.empno, e.ename,sum(e.sal) over (order by e.sal) from emp e ;
 select e.deptno as deptno , e.empno as empno, e.ename as ename ,e.sal as sal, sum(e.sal) over(order by sal asc ) as gsum from emp e where e.deptno=10
 union all 
 -- 按照部门的员工进行工资累加
 select e.deptno as deptno ,0 as empno, '--' as ename,sum(e.sal) as sal, 0 as gsum  from emp e group by e.deptno
 union all
 select -1 as deptno,-1 as empno, '--' as ename,sum(e.sal) as sal, 0 as gsum  from emp e
 --listagg写法
 select e.deptno as deptno,
        e.empno as empno,
        e.ename as ename,
        e.sal as sal,
        sum(e.sal) over(order by sal asc) as gsum,
        (select listagg(sal,'+') within group(order by empno) from emp a where a.deptno = 10 and a.empno<=e.empno ) as 计算公式
   from emp e
  where e.deptno = 10 order by e.empno 
 
 --6.5 排名
 select e.deptno as deptno,
        e.empno as empno,
        e.ename as ename,
        e.sal as sal,
        row_number() over(partition by e.deptno order by e.sal) as row_num,
        rank() over(partition by e.deptno order by e.sal) as rank_w,
        dense_rank() over(partition by e.deptno order by e.sal) as denserank
   from emp e
   order by deptno 
-- 6.6
select e.sal,count(*) as cnt from emp e group by sal;      

-- 6.7 各部门工资最高最低的人
select e.deptno,
       max(e.ename) keep(dense_rank first order by sal) over(partition by e.deptno) as 薪资最低的人,
       max(e.sal) keep(dense_rank first order by sal) over(partition by e.deptno) as 最低薪资,
       max(e.ename) keep(dense_rank last order by sal) over(partition by e.deptno) as 薪资最高的人,
       max(e.sal) keep(dense_rank last order by sal) over(partition by e.deptno) as 最高薪资,
       e.ename,
       e.sal
  from emp e;

-- 7.4
select  a.maxDay-a.minDay as 间隔日,
       months_between(a.maxDay,a.minDay) as 间隔月,
       months_between(a.maxDay,a.minDay)/12 as 间隔年
from (
select  max(e.HIREDATE) as maxDay, min(e.HIREDATE) as minDay from EMP  e
) a;

-- 7.7
select x.EMPNO,
       x.ENAME,
       x.HIREDATE,
       x.next_hd,
       coalesce(x.HIREDATE - x.next_hd, 0) as diff,
       coalesce(x.HIREDATE - x.pre_hd, 0)  as pre_diff
from (
         select e.EMPNO,
                e.ENAME,
                e.HIREDATE,
                lead(e.HIREDATE) over (order by e.HIREDATE) as next_hd,
                lag(e.HIREDATE) over (order by e.HIREDATE)  as pre_hd
         from EMP e
         where e.DEPTNO = 10
     ) x;
-- 8.1 获取月初
select HIREDATE , trunc(HIREDATE ,'mm') as 月初 from EMP where ROWNUM<=1;

select HIREDATE ,
       to_char(HIREDATE,'hh24') 时,
       to_char(HIREDATE,'mi') 分,
        to_char(HIREDATE,'ss') 秒,
        to_char(HIREDATE,'dd') 日,
        to_char(HIREDATE,'mm') 月,
        to_char(HIREDATE,'yyyy') 年,
        to_char(HIREDATE,'ddd') 年内第几天,
       trunc(HIREDATE,'dd') 一天之始,
        trunc(HIREDATE,'day') 周初,
       trunc(HIREDATE,'mm') 月初,
       last_day(HIREDATE) 月末,
       add_months(trunc(HIREDATE,'mm'),1) 下月初,
       trunc(HIREDATE,'yy') 年初,
       to_char(HIREDATE,'day') 周几,
       to_char(HIREDATE,'month') 月份
       from EMP where ROWNUM<=1;
-- 获取全年的月初,月末
-- 8.3
select HIREDATE,
       extract(YEAR from HIREDATE)            as year,
       extract(MONTH from HIREDATE)           as month,
       extract(DAY from HIREDATE)             as day
      -- extract(hour from HIREDATE)            as hour
       --extract(TIMEZONE_REGION from HIREDATE) as region
from EMP
where ROWNUM <= 3;

-- 8.11
-- 年份连续累加
with x as (select minYear + LEVEL - 1 as years
           from (
                    select max(extract(year from HIREDATE)) as maxYear,
                           min(extract(year from HIREDATE)) as minYear
                    from EMP
                )
           connect by LEVEL <= maxYear - minYear)
select e.HIREDATE , count(e.ENAME) as cnt
from x
         right join
        EMP  e on x.years = EXTRACT(YEAR  from e.HIREDATE)
group by e.hiredate
order by x.years desc;


-- 10.5
select *
from EMP e
where EMPNO in (
    select MIN(EMPNO) as minNo
    from EMP
    union all
    select MAX(EMPNO) as maxNo
    from EMP
);
select EMPNO
from (
         select EMPNO, MAX(EMPNO) over () as maxNo, min(EMPNO) over () as minNo from EMP
     ) x
where EMPNO in (maxNo, minNo);
