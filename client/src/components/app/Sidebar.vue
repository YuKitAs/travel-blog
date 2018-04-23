<template>
  <div class="tb-sidebar">
    <div class="tb-sidebar__content"
        :class="{'tb-sidebar__content--expanded': sidebarExpandedInSmallDevice}">
      <div class="tb-sidebar__logo-container">
        <img src="@/assets/images/logo.png" class="tb-sidebar__logo"/>
      </div>
      <h1 class="tb-sidebar__title">Captain Bonbon</h1>
      <navbar/>
    </div>
    <div class="tb-sidebar__tail-container" @click="toggleSidebarExpanded">
      <div class="tb-sidebar__tail">
        <img src="@/assets/images/expand-button.png"
            ref="expand-button"
            class="tb-sidebar__expand-button"
            :class="{'tb-sidebar__expand-button--collapse': sidebarExpandedInSmallDevice}"/>
      </div>
    </div>
  </div>
</template>

<script>
import Navbar from '@/components/app/Navbar';

export default {
  name: 'Sidebar',

  data() {
    return {
      sidebarExpandedInSmallDevice: false,
    };
  },

  methods: {
    toggleSidebarExpanded() {
      if (this.$refs['expand-button'].style.display === 'none') {
        return;
      }
      this.sidebarExpandedInSmallDevice = !this.sidebarExpandedInSmallDevice;
    },
  },

  components: {
    Navbar,
  },
};
</script>

<style lang="sass">
  @import "src/assets/styles/main"

  .tb-sidebar
    margin: 0 0.625em 0 0.625em

    &__content
      background-color: $dark-background-color
      @include page-width(small)
        padding-top: 0
        max-height: 0
        overflow: hidden
        transition: all 1s ease
      @include page-width(medium-and-up)
        padding-top: 2em

      &--expanded
        @include page-width(small)
          padding-top: 1em
          max-height: 110vh

    &__title
      text-align: center
      color: $light-text-color

    &__logo-container
      background-color: $light-text-color
      padding: 1em 0 1em 0

    &__logo
      display: block
      width: 50%
      margin: 0 auto 0 auto

    &__tail-container
      @include page-width(small)
        cursor: pointer

    &__tail
      background-color: $dark-background-color
      text-align: center
      padding-top: 40%
      padding-bottom: 60%
      height: 0
      border-radius: 0 0 50% 50%
      margin-top: -50%
      position: relative
      z-index: -1

    &__expand-button
      @include page-width(small)
        transition: transform 1s
      @include page-width(medium-and-up)
        display: none

      &--collapse
        @include page-width(small)
          transform: rotate(180deg)
</style>
