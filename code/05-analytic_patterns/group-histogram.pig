IMPORT 'common_macros.pig';

pl_yr_stats = load_bats();

G_vals = FOREACH pl_yr_stats GENERATE G;
G_hist = FOREACH (GROUP G_vals BY G) GENERATE 
  group AS G, COUNT(G_vals) AS n_seasons;

rmf                         /data/out/baseball/histogram_of_games;
STORE winloss_record2 INTO '/data/out/baseball/histogram_of_games';

-- -- We can separate out the two eras using the summing trick: 
-- 
-- G_vals = FOREACH pl_yr_stats GENERATE G,
--   (year_id <  1961 AND year_id > 1900 ? 1 : 0) AS G_154,
--   (year_id >= 1961                   ? 1 : 0) AS G_162
--   ;
-- G_hist = FOREACH (GROUP G_vals BY G) GENERATE 
--   group AS G,
--   COUNT(G_vals) AS n_seasons,
--   SUM(G_vals.G_154) AS n_seasons_154,
--   SUM(G_vals.G_162) AS n_seasons_162
--   ;
-- 
-- rmf                         /data/out/baseball/histogram_of_games_154_vs_162;
-- STORE winloss_record2 INTO '/data/out/baseball/histogram_of_games_154_vs_162';