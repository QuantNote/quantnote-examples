-- Retrieve swaps for given lp_token
-- CAUTION: DO NOT use order by yet (it is extremely slowing query down)

SELECT created_at,
       block,
       (select address from chain_bsc.addresses where id = log_swaps.sender_id) as from_address,
       (select address from chain_bsc.addresses where id = log_swaps.to_id) as to_address,
       (select symbol from chain_bsc.tokens where id = log_swaps.token0_id) as token0,
       (select symbol from chain_bsc.tokens where id = log_swaps.token1_id) as token1,
       amount0_in, amount0_out, amount1_in, amount1_out
FROM chain_bsc.log_swaps
WHERE address_id = ANY (ARRAY(SELECT id FROM chain_bsc.addresses where address = '0x0eD7e52944161450477ee417DE9Cd3a859b14fD0'))
limit 10;
