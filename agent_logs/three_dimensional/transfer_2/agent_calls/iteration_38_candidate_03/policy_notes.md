# Wake-policy candidate notes

## Evidence diagnosis before the edit

The four sampled solver policies, trajectories, and combined keyframe sheets
are byte-identical v41 captures, so they are one replicated finite example
rather than four independent control conditions.  They confirm direct uniform
still-water initialization, a coherent self-propelled alternating wake in both
the top-down mid-plane and oblique Lambda2 views, a smooth far approach, and a
sharp terminal hook.  They provide no disturbed-flow event from which to infer
a wake-rejection sign.  The inherited v42 headroom redistribution and v43
coupled anti-windup failures are therefore used only as nonvisual negative
comparators: both changed the terminal allocation without improving the route
or load class and consumed capture margin.

The repeated v41 trace captures at 24.640015T and 0.748356L with mean distance
2.347937L, zero sampled posterior hard-stop occupancy, about 13.84% total
exact-rate exposure, and the inherited low peak planar force/yaw-moment class
of 0.0254/0.0319/0.0156.  A narrower unresolved defect remains.  From the first
crossing of 1.25L through capture, the anterior joint is exactly at its
260 deg/T rate limit for 26 of 220 samples (11.82%); all 26 still apply
velocity-increasing acceleration.  At capture its rate is -260 deg/T and its
command is -18.261 rad/T^2.  The posterior joint is already protected and near
rest at -43.95 deg, so cross-joint redistribution is neither necessary nor
supported.

## Candidate hypothesis

Preserve v41's far route, course corridor, phase-selective steering, posterior
braking reserve, and posterior coast.  Inside a body-length-normalized 1.25L
terminal neighborhood only, taper the velocity-increasing anterior *carrier*
command as its measured rate enters the existing 250--260 deg/T band.  Retain
any anterior steering acceleration that opposes the measured joint velocity;
do not synthesize a brake, alter the posterior command, or transfer rejected
authority between joints.  This is a state-triggered approach-hold mechanism,
not a global gain change.

Expected evidence: no command difference before 1.25L; retained capture and
coherent terminal hook; lower anterior and total exact-rate occupancy without a
larger force/moment class.  Falsify the mechanism if capture or crossing margin
is lost, the trajectory changes before the terminal neighborhood, the carrier
phase anchor is disrupted, or rate/load exposure does not improve.

bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG modulation and terminal target capture
source_mechanism: preserve the observed propulsive oscillator while reducing excess drive near arrival through state feedback
transferable_invariant: separate rhythmic carrier effort from corrective steering and withdraw only velocity-increasing carrier effort when a measured terminal constraint is active
nontransferable_details: published gains, clocked oscillator phases, species-specific kinematics, exact vortex phases, and source-task routes
policy_translation: use normalized distance_L plus anterior joint rate normalized by the owned 250--260 deg/T envelope; keep rate-opposing steering while tapering only the local carrier contribution
falsification: reject on lost capture, pre-1.25L route change, worse crossing margin, disrupted coherent wake, or no reduction in anterior exact-rate exposure
