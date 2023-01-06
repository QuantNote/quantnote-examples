-- Retrieve swaps for given address

SELECT created_at,
       block,
       (select address from bsc.public.addresses where id = log_swaps.sender_id) as from_address,
       (select address from bsc.public.addresses where id = log_swaps.to_id) as to_address,
       (select symbol from bsc.public.tokens where id = log_swaps.token0_id) as token0,
       (select symbol from bsc.public.tokens where id = log_swaps.token1_id) as token1,
       amount0_in, amount0_out, amount1_in, amount1_out
FROM bsc.public.log_swaps
WHERE created_at >= timestamp '2022-07-01'
  and created_at <= timestamp '2022-07-23'
  and (sender_id = wallet('0xbaC14A55Da4327f79D69AF657AD6837aA49c9aC6') or
       to_id = wallet('0xbaC14A55Da4327f79D69AF657AD6837aA49c9aC6'))
limit 10;