<template>
  <div class="tb-article-card" @click="$emit('click')">
    <photo-frame :image-id="thumbnail" is-thumbnail/>
    <h2 class="tb-title">{{title}}</h2>
    <div class="tb-splitter">
      <span class="tb-horizontal-line tb-splitter-line"/>
      <span class="tb-line-head"/>
    </div>
    <div class="tb-meta-data">{{date}} | {{placeName}}</div>
    <p class="tb-introduction">{{introduction}}</p>
  </div>
</template>

<script>
import PhotoFrame from '@/components/articles/PhotoFrame'

export default {
  props: {
    thumbnail: {type: String, required: true},
    title: {type: String, required: true},
    date: {type: String, required: true},
    placeName: {type: String, required: true},
    introduction: {type: String, required: true}
  },

  components: {
    PhotoFrame
  }
}
</script>

<style lang="sass" scoped>
  @import "src/assets/styles/mixins"

  .tb-article-card
    width: $article-width
    margin-bottom: $space-width
    cursor: pointer

  .tb-title
    color: $theme-color-1
    margin-bottom: 0

  .tb-splitter
    display: flex
    align-items: center
    margin-bottom: 15px

  .tb-splitter-line
    display: inline-block
    width: calc(100% - 9px)
    height: 0
    border-bottom: 1px solid $theme-color-1

  .tb-meta-data
    color: $theme-color-1
</style>
