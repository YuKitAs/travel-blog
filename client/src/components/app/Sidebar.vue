<template>
  <div class="tb-sidebar">
    <div class="tb-sidebar__content">
      <div class="tb-sidebar__logo-container">
        <img src="@/assets/images/logo.png" class="tb-sidebar__logo"/>
      </div>
      <h1 class="tb-sidebar__title">Captain Bonbon</h1>
      <navbar/>
    </div>
    <div class="tb-sidebar__tail"></div>
  </div>
</template>

<script>
import Navbar from '@/components/app/Navbar';

export default {
  name: 'Sidebar',
  components: {
    Navbar,
  },
};
</script>

<style lang="sass">
  @import "src/assets/styles/main"

  .tb-sidebar
    margin: 0 0.625rem 0 0.625rem

    &__content
      background-color: $dark-background-color
      padding-top: 2rem

    &__title
      text-align: center
      color: $light-text-color

    &__logo-container
      background-color: $light-text-color
      padding: 1rem 0 1rem 0

    &__logo
      display: block
      width: 50%
      margin: 0 auto 0 auto

    &__tail
      background-color: $dark-background-color
      padding-bottom: 100%
      height: 0
      border-radius: 0 0 50% 50%
      margin-top: -50%
      position: relative
      z-index: -1
</style>
