-- Get most active tokens by means of number of swaps in last 24 hours

select t0.token0_id,
       (select t.symbol from bsc.public.tokens t where t.id = t0.token0_id) as token,
       t0.count + t1.count as count
from (SELECT token0_id, sum(count) as count
      from series.chain_bsc.swap_number_ticks_hourly
      where bucket >= now() - interval '24' hour
      group by token0_id) as t0
         join (SELECT token1_id, sum(count) as count
               from series.chain_bsc.swap_number_ticks_hourly
               where bucket >= now() - interval '24' hour
               group by token1_id) as t1 on token0_id = token1_id
order by count desc
limit 100;
