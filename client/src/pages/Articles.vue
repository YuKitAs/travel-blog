<template>
  <div class="tb-articles">
    <h1 class="tb-page-title">Articles</h1>
    <featured-article v-if="featuredArticle" :article-preview="featuredArticle"
      class="tb-featured-article-visible-mask"/>
    <article-list :article-previews="articlePreviews"/>
  </div>
</template>

<script>
import ArticleList from '@/components/common/ArticleList'
import FeaturedArticle from '@/components/articles/FeaturedArticle'

import ArticleService from '@/services/ArticleService'

export default {
  data() {
    return {
      featuredArticle: null,
      articlePreviews: []
    }
  },

  async mounted() {
    await this.fetchData()
  },

  methods: {
    async fetchData() {
      try {
        this.articlePreviews = (await ArticleService.getAll()).data
        this.featuredArticle = (await ArticleService.getFeatured()).data
      } catch (e) {
        this.$router.replace({name: 'Error'})
      }
    }
  },

  components: {
    ArticleList,
    FeaturedArticle
  }
}
</script>

<style lang="sass" scoped>
  @import "src/assets/styles/mixins"

  .tb-featured-article-visible-mask
    display: none
    @include page-width("large-and-up")
      display: block
</style>
