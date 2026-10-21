# By default both platforms are built in one go. CI sets ARCH (amd64 or arm64) to build a single
# platform on a native runner and push it as <tag>-<arch>; the manifest targets then join those
# per-architecture images under <tag>.
ARCH ?=
ARCHES := amd64 arm64
ALL_PLATFORMS := linux/amd64,linux/arm64
PLATFORMS := $(if $(ARCH),linux/$(ARCH),$(ALL_PLATFORMS))
ARCH_SUFFIX := $(if $(ARCH),-$(ARCH))

# $(call join-arches,<image>,<tag>) points <image>:<tag> at <image>:<tag>-<arch> for every arch.
join-arches = docker buildx imagetools create --tag $(1):$(2) $(foreach arch,$(ARCHES),$(1):$(2)-$(arch))
