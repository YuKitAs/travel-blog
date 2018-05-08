<template>
  <div class="tb-global-container">
    <div class="tb-content-container">
      <router-view/>
    </div>
    <div class="tb-sidebar-container">
      <sidebar/>
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
    display: flex
    flex-direction: column-reverse
    @include page-width("medium-and-up")
      flex-direction: row

  .tb-sidebar-container
    width: 100%
    @include page-width("medium-and-up")
      width: 150px

  .tb-content-container
    min-height: 100vh
    width: 300px
    padding: 0 calc((100vw - 300px) / 2) 0 calc((100vw - 300px) / 2)
    @include page-width("medium-and-up")
      width: 300px
      padding: 0 50px 0 50px
      border-width: 0
      border-style: solid
      border-color: $theme-color-2
      border-left-width: calc((100vw - 150px - 400px) / 2)
    @include page-width("large-and-up")
      width: 650px
      border-left-width: calc((100vw - 150px - 750px) / 2)
    @include page-width("xlarge-and-up")
      width: 1000px
      border-left-width: calc((100vw - 150px - 1100px) / 2)
</style>
