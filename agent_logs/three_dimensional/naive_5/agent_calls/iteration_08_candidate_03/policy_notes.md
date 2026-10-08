# Candidate wake-policy diagnosis

All four sampled rollouts report `uniform_direct` initialization with zero
background velocity, so the visible motion is self-propulsion rather than
inflow advection.  I inspected both the top-down vorticity and oblique
body/Lambda2 rows in every combined keyframe sheet.  The raw-yaw closure
sample (`solver_12fc3441a636`) makes a coherent but load-heavy wake and exits
the upper boundary at `20.790T`, with a `6.268L` minimum, anterior angle
contact, and much more speed/acceleration clipping than the useful redirect
samples.  The assigned distributed-tail parent (`solver_b6ed3f84ab58`) also
keeps a coherent three-dimensional wake, but stays above the target, reaches
only `5.386L`, touches the posterior angle limit, produces the largest sampled
lateral-force/yaw-moment spikes, and exits at `(8.770,15.201)L`.

The two response-released C-start descendants separate the missing mechanism
from raw score.  The joint-state-released redirect (`solver_29282ff8dbf4`)
visibly curves its coherent wake down through the target neighborhood and is
the only sampled policy to reach capture scale: `0.831L` at about `27.5T`,
with no angle contact and lower limit residence than the parent.  Its
projected body-frame course miss falls from about `1.08L` near `1.28L`
distance to about `0.82L` at closest approach, only `0.07L` outside capture;
it then crosses from positive closing speed to recession and makes a large
loop.  In contrast, qualifying all redirect release by projected intercept
(`solver_b3b6be8f076f`) holds the same-sign bend instead of pulsing it, returns
to the high corridor, and regresses to a `4.278L` minimum.  The inherited
parent logs independently contain an earlier response-released redirect that
reached `1.165L` but released while its predicted miss remained several body
lengths.  Together these results support intermittent response release and a
separate terminal energy schedule; they reject a continuously latched
intercept bend, posterior-wave redistribution, raw-yaw closure, and another
scalar steering-gain increase.

Policy hypothesis: start from the observed joint-state-released redirect.
Preserve its carrier, calibrated steering sign, bend/yaw response release, and
posterior lag.  Only inside a body-frame, distance-normalized terminal region,
when positive closing speed and projected miss show that the current course
will pass outside capture, smoothly reduce cruise-wave drive and reinforce the
targets of each already-pulsed redirect.  This should give curvature more time
to remove the final `0.07L` miss without suppressing the alternating carrier
on the far approach.  The terminal gate must fall away after closing ceases,
so a failed pass cannot become a static-curvature latch.

bookshelf_consulted: true
source_domain: biological C-start redirection and terminal interception control
source_mechanism: response-released burst curvature with far/middle/near approach energy scheduling
transferable_invariant: use strong curvature only for large observed error, release it on observed body response, and trade propulsive drive for corrective authority when a closing near-target course still predicts a miss
nontransferable_details: species kinematics, published gains, dimensional frequencies, exact vortex phase, and any fixed route or maneuver duration
policy_translation: infer gait phase from joint state; form projected miss, distance, and closing gates from normalized body-frame observations; retain response-released two-joint bends while smoothly relieving cruise drive and increasing bend target only in the terminal miss regime
falsification: reject if the coherent alternating wake disappears before `2L`, limit residence or load spikes increase, closest approach does not beat `0.831L`, the fish turns away before capture, or the terminal gate remains active after recession
