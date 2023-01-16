-- Get all moves for given wallet by its ID grouped by tokens

SELECT bucket,
       token_id,
--        (select t.symbol from bsc.public.tokens t where t.id = token_id) as token,    -- labeling which is very slow at the moment
       sum(cast(move as decimal(38, 18))) as move
FROM series.chain_bsc.balance_move_ticks_hourly
WHERE bucket >= now() - interval '5' day
  and wallet_id = wallet('0x7712Ff14318154300E845ed020b53c014B03BCab')
group by token_id, bucket
order by 1;