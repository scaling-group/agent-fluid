# Candidate wake-policy notes

## Evidence diagnosis

The shared prewarm sheet shows the common held fish above and downstream of
the developed asymmetric four-cylinder streets; it is identical initial-state
evidence, not a policy comparison. In every released sheet the fish is
self-propelled upstream rather than merely advected: mean streamwise head
velocity is about `-0.13` to `-0.14`, more negative than the sampled mean local
flow (`-0.09` to `-0.10`). The fish initially closes on the target from above
and to the right, but never reaches the useful second-row wake region. Near its
closest approach it bends into a broad counterclockwise/upward curl; the final
frames show an almost vertical fish leaving the upper boundary. This visible
failure agrees with every sampled `left_domain` termination and the nearly
invariant `+1.75L` to `+1.80L` head-y displacement.

The static `11 deg` posterior-bias prefill is the strongest finite sample:
`-7.89L` head-x displacement, `4.87L` closest approach, and `0.424` progress.
The otherwise matched `10 deg` sample reaches only `-6.93L`, `5.33L`, and
`0.380`, so the extra degree is useful far-field authority. It is not a route
repair: y drift remains `+1.79L`, posterior angle reaches `0.781 rad`, both
joint rate/command limits are hit, and RMS force/moment rise from `325/3331`
to `406/4113`.

The sampled follow-ups make two negative results concrete. Reducing the
`11 deg` bias toward a `0.70` floor inside `6L` loses upstream travel
(`-7.19L`), progress (`0.393`), and mean distance (`7.85L`) while leaving y
drift (`+1.78L`), the upper curl, and limit hits essentially unchanged. At the
`10 deg` anchor, a measured `40--45 deg` posterior angle/outward-rate soft
stop worsens closest approach from `5.33L` to `5.77L`, raises RMS loads from
`325/3331` to `357/3779`, and does not lower peak posterior angle (`0.772`
versus `0.770 rad`). Distance-only relief and this near-limit servo therefore
do not address the persistent lateral failure.

## Single candidate hypothesis

Keep the full sampled propulsion gait, `11 deg` static posterior authority,
and `0.70/0.35` heading-rate anchor. Add only a bounded damping term from the
normalized body-frame lateral velocity to the posterior steering command.
Unlike bearing-rate feedback, this signal does not mix target-vector
translation into the derivative; unlike distance or phase relief, it acts on
the observed lateral motion while leaving zero-slip propulsion unchanged. Use
a modest `0.20` dimensionless gain and a `0.10` velocity scale so the new term
can trim established lateral slip but cannot override the bearing command.

The hypothesis is supported only if the rollout preserves roughly the
`11 deg` anchor's upstream progress while reducing upper drift/curl and either
closest approach or saturation/load. It is falsified if upstream travel falls
materially, y displacement remains near `+1.8L`, or the load/limit pattern
worsens. A failure would mean later workers should restore the static
`11 deg` anchor and distrust lateral-velocity damping as a proxy for the
global upper-exit mechanism.
