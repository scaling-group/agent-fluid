# Wake-policy candidate notes

## Evidence diagnosis

- The assigned parent guidance requires normalized body-frame feedback, visual-first diagnosis, bounded actuation, and a reusable evidence update. No inherited `logs/optimize/` artifact was present in this fresh workspace, so the sampled seed rollout is the only completed candidate evidence available.
- The sampled transferred 2D seed was evaluated with direct uniform still-water initialization (`U_infinity=[0,0,0]`), no cylinders, and no prewarm. It failed by `left_domain` at `27.495T`: distance fell from `12.328L` to `4.780L` at about `17.853T`, then increased to `9.709L` before the lower-boundary exit.
- In the top-down sheet, the fish self-propels and leaves a strong alternating wake. It initially follows a useful down-left path, but its heading repeatedly swings across the target bearing and the trajectory curls downward after closest approach. The oblique Lambda2 sheet confirms a coherent three-dimensional vortex train rather than passive advection or loss of propulsion; the route failure is dominated by yaw control.
- The quantitative history agrees with the images. At `8.003T`, bearing is about `+0.259 rad` while yaw rate is `-1.867 rad/T`, already rotating toward the target. By `11.000T` it has crossed to bearing `-0.096 rad`; at `16.005T`, bearing is `+1.045 rad` while yaw rate is again the wrong-sign `+2.900 rad/T`. Peak absolute yaw rate is `3.140 rad/T`. Both joint-speed limits (`260 deg/T`) are reached, and raw policy acceleration exceeds the `1800 deg/T^2` actuator envelope on `97.9%` of samples. These facts make more cadence or undifferentiated steering gain poor first interventions.
- The seed already has yaw-rate feedback, but it sums the geometric turn request and rate correction before actuation. Its only response-release terms are multiplied by `close_gate`, so they are inactive throughout this rollout because distance never enters the `2.1L` approach region. The candidate hypothesis is to separate route steering from braking: attenuate only the geometry-driven part when measured yaw has the same sign as the requested turn, while retaining the yaw-rate correction so it can brake an excessive response.

## Structured bookshelf transfer

bookshelf_consulted: true
source_domain: biological C-start redirect and sensor-modulated robotic-fish CPG control
source_mechanism: apply a bounded redirect for target error, then release that redirect when the observed heading response has appeared
transferable_invariant: persistent target error should initiate steering, but correct-sign measured rotation should reduce the route bias before delayed body and wake dynamics cause an overshoot
nontransferable_details: species-specific C-start shapes, published gains and timing, open-loop CPG phase, exact vortex phase, and task-specific routes
policy_translation: derive desired turn sign from bounded body-frame target geometry; smoothly gate only the geometric request with normalized recent yaw rate, then add the existing rate-error correction un-gated and retain the two-joint state-feedback oscillator
falsification: reject the transfer if the rollout retains the same repeated yaw reversals and lower-boundary exit, loses its coherent propulsive wake, or fails to improve on `4.780L` minimum distance without a better termination class; a useful result should reduce post-response steering and keep distance decreasing beyond the seed's closest-approach epoch

## Candidate scope

This is one mechanism-level candidate, not a gain sweep. It preserves the seed gait, target geometry, approach schedule, and actuator mapping, and adds a smooth far-field response-release gate with all active constants owned by `target_policy_params()`.

## Pre-evaluation checks

- Algebraic replay on recorded seed observations changes the command only when the measured yaw agrees with the geometric request. At `8.003T`, the gate is about `0.104` and turns the seed's `+0.500` braking request into `+1.172` by releasing an opposing geometric bias while retaining rate correction. At closest approach near `17.853T`, the gate is about `0.165` and reduces a correct-sign route request from `-3.672` to `-0.295`. This is an offline policy comparison, not new CFD evidence.
- The lightweight policy contract, direct parameter-field ownership check, and solver-boundary check pass. Formal CFD remains deferred to the evaluator after this worker exits.
