# Quick checks for trajectory-style indicators
# This script uses a tiny synthetic dataset (data/sample_trajectory.csv)
d <- read.csv("data/sample_trajectory.csv")
# 1) How many episodes per child?
episodes_per_child <- aggregate(episode_id ~ child_id, data = d, FUN = length)
names(episodes_per_child)[2] <- "n_episodes"
print(episodes_per_child)
# 2) Average recovery time (seconds to level 1), by child
avg_recovery <- aggregate(seconds_to_level1 ~ child_id, data = d, FUN = mean)
names(avg_recovery)[2] <- "avg_seconds_to_level1"
print(avg_recovery)
# 3) Re-engagement rate by child
reengage_rate <- aggregate(reengaged ~ child_id, data = d, FUN = mean)
names(reengage_rate)[2] <- "reengage_rate"
print(reengage_rate)
# 4) Do episodes get faster or slower? (simple slope idea)
# Here we just compare first vs last episode recovery time per child
first_last <- do.call(rbind, lapply(split(d, d$child_id), function(x) {
  x <- x[order(x$episode_order), ]
  data.frame(
    child_id = x$child_id[1],
    first_seconds = x$seconds_to_level1[1],
    last_seconds = x$seconds_to_level1[nrow(x)]
  )
}))
first_last$change <- first_last$last_seconds - first_last$first_seconds
print(first_last)
