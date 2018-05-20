<template>
  <div class="tb-featured-article">
    <img :src="thumbnail" class="tb-thumbnail"/>
    <div class="tb-info-card-anchor">
      <div class="tb-info-card">
        <h2 class="tb-title">{{title}}</h2>
        <div class="tb-meta-data">{{date}} | {{placeName}}</div>
        <p class="tb-introduction">{{introduction}}</p>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  props: {
    thumbnail: {type: String, required: true},
    title: {type: String, required: true},
    date: {type: String, required: true},
    placeName: {type: String, required: true},
    introduction: {type: String, required: true}
  }
}
</script>

<style lang="sass" scoped>
  @import "src/assets/styles/mixins"

  .tb-featured-article
    width: 100%
    margin: 25px 0 $space-width 0

  .tb-thumbnail
    width: 100%
    max-height: auto

  .tb-title
    color: $theme-color-1-shaded-1
    margin-bottom: 0.5em

  .tb-meta-data
    color: $theme-color-1-shaded-1

  .tb-info-card-anchor
    height: 0

  .tb-info-card
    position: relative
    transform: translateY(-100%)
    top: -50px
    width: 55%
    padding: 1px 20px 1px 20px
    background: rgba(255, 255, 255, 0.8)
</style>
