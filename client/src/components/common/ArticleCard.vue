<template>
  <div class="tb-article-card">
    <photo-frame :image-id="articlePreview.thumbnail.id"
        is-thumbnail @click="navigateTo(articlePreview.id)" @load="$emit('load')"/>
    <h2 class="tb-title" @click="navigateTo(articlePreview.id)">{{articlePreview.title}}</h2>
    <div class="tb-splitter">
      <span class="tb-horizontal-line tb-splitter-line"/>
      <span class="tb-line-head"/>
    </div>
    <metadata :date="articlePreview.date" :place="articlePreview.place"/>
    <p class="tb-introduction">{{articlePreview.introduction}}</p>
  </div>
</template>

<script>
import Metadata from '@/components/common/Metadata'
import PhotoFrame from '@/components/articles/PhotoFrame'

export default {
  props: {
    articlePreview: {type: Object, required: true}
  },

  methods: {
    navigateTo(articleId) {
      this.$router.push({name: 'Articles.Article', params: {articleId}})
    }
  },

  components: {
    Metadata,
    PhotoFrame
  }
}
</script>

<style lang="sass" scoped>
  @import "src/assets/styles/mixins"

  .tb-article-card
    width: $article-width
    margin-bottom: $space-width * 1.5

  .tb-photo-frame
    cursor: pointer

  .tb-title
    margin-top: 10px
    margin-bottom: 0
    cursor: pointer
    &:hover
      color: $theme-color-1-highlighted-2

  .tb-splitter
    display: flex
    align-items: center
    margin-bottom: 10px

  .tb-splitter-line
    display: inline-block
    width: calc(100% - 9px)
    height: 0
    border-bottom: 1px solid $theme-color-1
</style>
