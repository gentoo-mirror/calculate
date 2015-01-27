# Calculate append=skip

The ac_desktop_merge event:
- package installation (not chroot*)
- package removal (not chroot)
- system setup
- first boot


*The event will not be used while the system is being built or if the package
is being installed in builder mode.

Action: package configuration
env: desktop
