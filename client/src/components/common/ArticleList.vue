<template>
  <div class="tb-article-list">
    <div ref="column" v-for="(column, index) in columns" :key="index" class="tb-column">
      <article-card v-for="articlePreview in column" :key="articlePreview.id" :article-preview="articlePreview"
        @click="navigateTo(articlePreview.id)"/>
    </div>
  </div>
</template>

<script>
import _ from 'lodash'
import ArticleCard from '@/components/common/ArticleCard'
import Responsive from '@/services/Responsive'

export default {
  props: {
    articlePreviews: {type: Array, default: () => []}
  },

  data() {
    return {
      columns: []
    }
  },

  watch: {
    articlePreviews(articlePreviews) {
      this.rearrangeArticles(articlePreviews)
    }
  },

  mounted() {
    window.addEventListener('resize', () => this.rearrangeArticles(this.articlePreviews))
  },

  methods: {
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
    ArticleCard
  }
}
</script>

<style lang="sass" scoped>
  @import "src/assets/styles/mixins"

  .tb-article-list
    display: flex
    align-items: flex-start
    justify-content: space-between

  .tb-column
      width: 300px
</style>
