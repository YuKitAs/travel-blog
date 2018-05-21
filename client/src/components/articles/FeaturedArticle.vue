<template>
  <div class="tb-featured-article">
    <photo-frame :image-id="articlePreview.thumbnail.id" @click="navigateTo(articlePreview.id)"/>
    <div class="tb-info-card-anchor">
      <div class="tb-info-card">
        <h2 class="tb-title" @click="navigateTo(articlePreview.id)">{{articlePreview.title}}</h2>
        <metadata :date="articlePreview.date" :place="articlePreview.place"/>
        <p class="tb-introduction">{{articlePreview.introduction}}</p>
      </div>
    </div>
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

  .tb-featured-article
    width: 100%
    margin: 20px 0 $space-width 0
    cursor: pointer

  .tb-title
    margin-bottom: 0.5em
    &:hover
      color: $theme-color-1-highlighted-2

  .tb-info-card-anchor
    height: 0

  .tb-info-card
    position: relative
    transform: translateY(-100%)
    top: -50px
    width: 55%
    padding: 1px 20px 1px 20px
    background: rgba(255, 255, 255, 0.88)
</style>
