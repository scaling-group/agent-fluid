# Course-loss-gated adverse-yaw work allocation

## Evidence diagnosis before the policy edit

All four sampled evaluations satisfy the direct-uniform still-water contract:
`U_infinity=(0,0,0)`, no cylinders, no prewarm, finite capture, and complete
combined keyframe sheets. The three byte-identical one-sided signed-allocation
samples are the strongest finite reference. They capture at `16.932T`, score
`-0.200045`, and have mean/final distances `2.08513L/0.74389L`. Peak fish
speed is `1.391U` while peak sampled local flow is only `0.03270U`; joint
speeds remain sublimit at `258.93/259.20 deg/T`, and peak force/yaw moment are
`0.03693/0.01835`.

Reading the repeated strong sheet from release through capture, the top-down
row grows from a quiescent release into a coherent alternating red/blue street
attached to a smooth target-directed trajectory. The oblique row retains
compact three-dimensional Lambda2 structures behind the posterior body and
caudal fan. The fish is self-propelled, its lateral rhythm remains productive,
and neither view shows a fixed-joint coast, wake collapse, collision, or hard
stop before capture.

The sampled bidirectional-suppression contrast is visually almost identical
and still captures, but its `2.08585L` mean distance and `-0.200966` score are
worse despite arriving `0.006T` earlier. This confirms that an intact wake and
higher `1.393U` peak speed do not validate extra arbitration by themselves.
The inherited parent continuation is the sharper negative result: increasing
posterior steering reserve whenever instantaneous yaw moment opposed the turn
request arrived at `16.883T`, but worsened mean/final distance to
`2.08817L/0.74832L`, score to `-0.204068`, posterior excursion from `0.5992`
to `0.6722 rad`, and peak force from `0.03693` to `0.03737`. Its sheet still
shows coherent alternating top-down and compact oblique shedding, so this is a
work-allocation/trajectory regression rather than loss of propulsion.

The sampled strong trace also identifies a discriminating observation for the
existing adverse-yaw anterior residual. Its substantial posterior-donor events
occur both when the velocity course is visibly misaligned with the target ray
(course errors around `0.28--0.42 rad`, radial course efficiency roughly
`0.91--0.96`) and when it is already nearly aligned (errors around
`0.06--0.14 rad`, efficiency roughly `0.99--1.00`). Instantaneous adverse yaw
alone cannot distinguish those states. The inherited evidence therefore
supports preserving the established base transfer and the large-error signed
residual, while withholding only discretionary extra work during already
productive radial motion.

## Policy hypothesis

Preserve the captured zero-centered anterior oscillator, posterior lagged
carrier, body-frame velocity-course steering, fixed posterior acceleration
reserve, soft command shoulder, high-onset positive-power speed guards,
bidirectional base transfer, signed adverse-yaw residual, and kinetic posterior
angle projection. Change only the residual's permission: multiply its existing
smooth adverse-yaw gate by a smooth normalized course-loss gate. The new gate
is zero while target-ray/velocity alignment is near unity and reaches unity
only for materially oblique motion. Base transfer, low-speed carrier work, and
both mechanical guards remain unchanged.

This is a response-and-progress-conditioned work-allocation mechanism, not a
carrier-gain retune. It should retain the large-error correction that produced
the repeated `-0.200045` capture while avoiding extra anterior work when the
fish is already translating efficiently toward the target. Falsify it if it
loses capture or alternating three-dimensional shedding, touches either speed
or acceleration limit, fails to match the `2.08513L` mean distance, or exceeds
the sampled `0.5993 rad` posterior-angle and `0.0370/0.0184` force/moment
envelope. A lower load without matched capture and route quality is not enough.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG control and wake-disturbance residual control
source_mechanism: preserve a coupled propulsive rhythm and admit bounded corrective work only when sensor feedback identifies task-relevant loss of direction
transferable_invariant: a residual should require agreement between target-relative intent, adverse measured response, and degraded target-directed motion while leaving the traveling carrier intact
nontransferable_details: published gains, dimensional frequencies, species-specific kinematics, duty ratios, full-body oscillator networks, exact vortex phases, and task-specific routes
policy_translation: retain joint-state carrier phase and the existing body-frame turn-by-yaw gate; multiply only its discretionary posterior-to-anterior increment by a smooth gate derived from the cosine of wrapped target-ray/velocity-course error
falsification: reject if capture, coherent alternating shedding, course progress, sublimit actuation, posterior clearance, or sampled force/moment bounds fail relative to the repeated one-sided signed-allocation reference
