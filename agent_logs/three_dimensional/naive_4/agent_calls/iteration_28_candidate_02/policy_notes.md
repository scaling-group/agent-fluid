# Demodulated middle-approach half-cycle candidate

## Evidence diagnosis before the policy edit

- All four sampled solver results satisfy the frozen rollout contract and are
  exact policy/trajectory replications: direct uniform initialization in still
  water with `U_infinity=(0,0,0)`, no prewarm or cylinders, capture after
  2,919 steps at `16.054371T`, and 239 moving-window shifts. Their candidate
  and combined-sheet hashes are byte-identical, so there is no distinct failed
  termination to compare in this allocation.
- I inspected the combined sheet from release through capture, including the
  top-down vorticity row and oblique body/Lambda2 row. It shows a smooth
  target-directed turn, a coherent alternating wake that lengthens behind the
  fish, and compact three-dimensional caudal structures. With zero imposed
  flow and `93.95%` distance progress, this is self-propulsion rather than
  advection. There is no visible collision, virtual exit, wake breakup, or
  out-of-plane instability; the remaining opportunity is below the sheet's
  visual resolution in the closing response.
- Every sampled copy captures at `0.745845616L`, scores `-0.046899933`, and has
  a `1.929839552L` scored distance integral. The representative trace has mean
  absolute posterior command `24.584520 rad/T^2`, posterior acceleration-limit
  residence `21.788%`, peak lateral force `0.032388 L^2`, and peak yaw moment
  `0.019026 L^3`. The final samples retain strong line-of-sight reopening and
  target-signed yaw while the anterior drive reaches its acceleration limit;
  this supports preserving propulsion and changing only the posterior response
  allocation.
- The assigned-parent and inherited step-24 through step-27 logs establish a
  narrow hierarchy. Separate yaw/slip mean brakes reached `-0.046924004`,
  slip-conditioned posterior half-cycle relief reached `-0.046922579`, a net
  line-of-sight mean damper reached `-0.046908385`, and carrier-demodulated
  middle-approach mean damping reached the replicated `-0.046899933`. Broader
  raw-bearing-rate half-cycle relief regressed to `-0.046998432`. Thus the
  evidence supports the demodulated residual as the selector and rules out
  another raw-rate gate, scalar onset retune, or broad carrier change.

## Bookshelf transfer

bookshelf_consulted: true
source_domain: asymmetric robotic-fish flapping and closed-loop CPG path following
source_mechanism: retain a traveling-wave carrier while selectively relieving the half-cycle that opposes a measured turn response
transferable_invariant: a persistent navigation residual can shape the counterproductive carrier lobe without amplifying the aiding lobe or shifting the entire oscillator
nontransferable_details: published duty ratios and gains, clock-defined CPG phase, species-specific envelopes, dimensional frequencies, exact vortex phases, and task-specific routes
policy_translation: preserve the two-joint carrier and carrier-demodulated body-frame line-of-sight mean correction; while its reliable middle-approach gate is active, infer posterior beat side from joint state and attenuate only the posterior wave lobe opposite that correction
falsification: reject if action appears outside the closing safe-intercept corridor, either wave lobe is amplified, pre-corridor milestones or wake coherence change, capture is delayed or lost, posterior limiting or loads rise materially, or the mechanism produces only clamp-equivalent commands

## One candidate hypothesis

Add one bounded half-cycle allocation to the sampled-best policy. The signed
carrier-demodulated line-of-sight correction already used for posterior mean
curvature also defines which posterior wave lobe opposes that correction. A
new owned relief fraction attenuates only that lobe, only under the existing
middle-approach closing/corridor/residual gate, and is combined with the
existing steering relief through a `[0,1]` wave-scale clamp. The aiding lobe
and the entire raw terminal line-of-sight damper are unchanged. The existing
pointwise raw-command guard remains the final allocator, so the translated
mechanism can only replace a feasible posterior action when it is no larger in
magnitude on the current state.

Expected evaluation evidence is the same coherent wake, cruise route,
milestones, and capture class, with a measurable improvement in closing
distance integral or terminal crossing and no material increase in limit
residence or loads. Because CFD runs only after this worker exits, this is a
falsifiable candidate hypothesis rather than a claimed outcome.

## Non-CFD verification after the edit

- Candidate SHA-256 is
  `f7bbf4e9c32a386b9699f1168741b1f0792ea1270e8e135e63ef5fdc2af2dbf8`.
  All 49 direct `params.FIELD` names resolve to the 49 fields returned by
  `target_policy_params()`.
- The required material guidance check, lightweight Julia policy contract,
  and solver editable-boundary check pass. The configured check-runner was
  invoked first, but its pinned `gpt-5.4-mini` model is unavailable for this
  account; its three prescribed checks were therefore run directly and
  separately. No CFD was run.
- A deterministic 23,328-state sweep over target side/distance, body-frame
  course, line-of-sight and yaw response, and anterior joint phase returns
  finite bounded commands, has zero numerical lateral-reflection error, keeps
  exact joint-speed-boundary commands non-outward, and exactly passes the new
  branch through in the far field. Non-finite task observations retain a
  finite fallback.
- Counterfactual evaluation on the sampled trajectory's reconstructed
  body-frame observations confirms that zero relief is exactly identical to
  the sampled parent. The active candidate changes posterior action on one
  middle-approach sample at `1.517562L`, by `0.574083 rad/T^2`; it changes no
  anterior or below-`0.90L` terminal action and never increases instantaneous
  posterior command magnitude on those states. This establishes a feasible,
  non-clamp-equivalent mechanism but not its unevaluated closed-loop benefit.
