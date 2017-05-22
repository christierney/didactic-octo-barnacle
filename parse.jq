.[] |
[ .times.requestBegin,
  .durations.latency,
  .durations.total, 
  .response.sizes.headers, 
  .response.sizes.body, 
  (.response.header.headers | map({(.name): .value}) | add |
    (."X-Cache-CF" | contains("Hit")?//false) and (."X-Cache" | contains("MISS")?//false) and (."X-Cache-Remote" | contains("MISS")?//false),
        (."X-Cache-Remote" | contains("HIT")?//false),
        (."X-Cache" | contains("HIT")?//false)
  )
] |
@csv

