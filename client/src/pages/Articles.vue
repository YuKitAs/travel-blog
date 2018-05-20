<template>
  <div class="tb-articles">
    <featured-article
      :thumbnail="require('@/assets/images/im2.jpg')"
      title="Hello world!"
      date="May. 13, 2018"
      placeName="Home"
      introduction="#0 Yes, it is the very very first article. Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."
      class="tb-featured-article-visible-mask"/>
    <div class="tb-columns">
      <div ref="column" v-for="(column, index) in columns" :key="index" class="tb-column">
        <article-card v-for="article in column" :key="article.id"
          :thumbnail="article.thumbnail.id"
          :title="article.title"
          :date="article.date"
          :place-name="article.place.name"
          :introduction="article.introduction"
          @click="navigateTo(article.id)"/>
      </div>
    </div>
  </div>
</template>

<script>
import _ from 'lodash'
import ArticleCard from '@/components/articles/ArticleCard'
import FeaturedArticle from '@/components/articles/FeaturedArticle'
import ArticleService from '@/services/ArticleService'
import Responsive from '@/services/Responsive'

export default {
  data() {
    return {
      featuredArticle: null,
      articles: [],
      notArrangedArticles: [],
      columns: []
    }
  },

  async mounted() {
    await this.fetchData()

    this.rearrangeArticles(this.articles)

    window.addEventListener('resize', () => this.rearrangeArticles(this.articles))
  },

  methods: {
    async fetchData() {
      const response = await ArticleService.getMany()
      this.articles = response.data
    },

    navigateTo(articleId) {
      this.$router.push({name: 'Articles.Article', params: {articleId}})
    },

    rearrangeArticles(notArrangedArticles) {
      if (Responsive.XLARGE_AND_UP) {
        this.columns = [[], [], []]
      } else if (Responsive.LARGE_AND_UP) {
        this.columns = [[], []]
      } else {
        this.columns = [[]]
      }

      notArrangedArticles.forEach(notArrangedArticle => {
        setTimeout(() => {
          const heights = this.columns.map((articles, index) => {
            const thumbnailHeight = articles.reduce((totalHeight, article) => totalHeight + article.thumbnail.height, 0)
            const textHeight = _.get(this.$refs.column[index], 'scrollHeight', 0)
            return thumbnailHeight + textHeight
          })

          let indexOfColumnWithMinHeight = 0

          heights.forEach((height, index) => {
            if (height < heights[indexOfColumnWithMinHeight]) {
              indexOfColumnWithMinHeight = index
            }
          })

          this.columns[indexOfColumnWithMinHeight].push(notArrangedArticle)
        }, 0)
      })
    }
  },

  components: {
    ArticleCard,
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

  .tb-columns
    display: flex
    align-items: flex-start
    justify-content: space-between

  .tb-column
      width: 300px
</style>
