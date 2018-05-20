<template>
  <div class="tb-global-container">
    <div class="tb-content-container">
      <router-view/>
    </div>
    <div class="tb-menu-container">
      <main-menu/>
    </div>
  </div>
</template>

<script>
import MainMenu from '@/components/app/MainMenu'

export default {
  name: 'App',
  components: {
    MainMenu
  }
}
</script>

<style lang="sass">
  @import "src/assets/styles/mixins"
  @import "src/assets/styles/main"
  @import "src/assets/styles/reset"

  .tb-global-container
    display: flex
    flex-direction: column-reverse
    @include page-width("medium-and-up")
      flex-direction: row

  .tb-menu-container
    width: 100%
    @include page-width("medium-and-up")
      position: fixed
      left: calc((100vw - #{content-width(1) + $menu-width}) / 2 + #{content-width(1)})
      width: $menu-width
    @include page-width("large-and-up")
      left: calc((100vw - #{content-width(2) + $menu-width}) / 2 + #{content-width(2)})
    @include page-width("xlarge-and-up")
      left: calc((100vw - #{content-width(3) + $menu-width}) / 2 + #{content-width(3)})

  .tb-content-container
    min-height: calc(100vh - 20px)
    width: $article-width
    padding: 10px calc((100vw - #{$article-width)}) / 2)
    @include page-width("medium-and-up")
      width: $article-width
      padding: 5px ($space-width - $content-offset) 10px ($space-width + $content-offset)
      border-width: 0
      border-style: solid
      border-color: $theme-color-2
      border-left-width: calc((100vw - #{content-width(1) + $menu-width}) / 2)
    @include page-width("large-and-up")
      width: $article-width + $space-width + $article-width
      border-left-width: calc((100vw - #{content-width(2) + $menu-width}) / 2)
    @include page-width("xlarge-and-up")
      width: ($article-width + $space-width) * 2 + $article-width
      border-left-width: calc((100vw - #{content-width(3) + $menu-width}) / 2)
</style>
