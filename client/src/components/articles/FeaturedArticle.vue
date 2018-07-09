<template>
  <div v-if="loaded" class="tb-featured-article">
    <photo-frame :image-id="featuredArticle.thumbnail.id" @click="navigateTo(featuredArticle.id)"/>
    <div class="tb-info-card-anchor">
      <div class="tb-info-card">
        <h2 class="tb-title" @click="navigateTo(featuredArticle.id)">{{featuredArticle.title}}</h2>
        <metadata :date="featuredArticle.date" :place="featuredArticle.place"/>
        <p class="tb-introduction">{{featuredArticle.introduction}}</p>
      </div>
    </div>
  </div>
</template>

<script>
import Metadata from '@/components/common/Metadata'
import PhotoFrame from '@/components/articles/PhotoFrame'

import ArticleService from '@/services/ArticleService'

export default {
  data() {
    return {
      loaded: false,
      featuredArticle: null
    }
  },

  async mounted() {
    await this.fetchData()
  },

  methods: {
    async fetchData() {
      try {
        this.featuredArticle = (await ArticleService.getFeatured()).data
        this.loaded = true
      } catch (e) {
        this.loaded = false
      }
    },

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
    display: none
    @include page-width("large-and-up")
      display: block
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
