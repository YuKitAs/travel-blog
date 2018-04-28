<template>
  <div class="tb-global-container">
    <div class="tb-sidebar-container">
      <sidebar/>
    </div>
    <div class="tb-content-container">
      <router-view/>
    </div>
  </div>
</template>

<script>
import Sidebar from '@/components/app/Sidebar'

export default {
  name: 'App',
  components: {
    Sidebar
  }
}
</script>

<style lang="sass">
  @import "src/assets/styles/main"
  @import "src/assets/styles/reset"

  .tb-global-container
    @include page-width(medium-and-up)
      @include make-row
    @include page-width(small)
      @include make-column
    margin: 0 auto 0 auto
    width: 100%
    max-width: $bp-large-max

  .tb-sidebar-container
    width: 12.5rem

  .tb-content-container
    @include make-fill-rest-space
    padding: 0 0.625rem 0 0.625rem
</style>
