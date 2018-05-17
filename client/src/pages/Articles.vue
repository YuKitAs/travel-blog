<template>
  <div class="tb-articles">
    <featured-article
      :thumbnail="require('@/assets/images/im2.jpg')"
      title="Hello world!"
      date="May. 13, 2018"
      placeName="Home"
      intro="#0 Yes, it is the very very first article. Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."
      class="tb-featured-article-visible-mask"/>
    <div class="tb-columns">
      <div ref="column" v-for="(column, index) in columns" :key="index" class="tb-column">
        <article-card v-for="article in column" :key="article.id"
          :thumbnail="article.thumbnail.path"
          :title="article.title"
          :date="article.date"
          :place-name="article.placeName"
          :intro="article.intro"/>
      </div>
    </div>
  </div>
</template>

<script>
import ArticleCard from '@/components/articles/ArticleCard'
import FeaturedArticle from '@/components/articles/FeaturedArticle'
import Responsive from '@/services/Responsive'

export default {
  data() {
    return {
      articles: [],
      notArrangedArticles: [],
      columns: []
    }
  },

  mounted() {
    this.articles = [
      {
        id: '1',
        thumbnail: {
          path: require('@/assets/images/im4.jpg'),
          height: 464
        },
        title: 'A Very Very Very Loooooooong Article',
        date: 'May. 12, 2018',
        placeName: 'Home',
        intro: '#1 Hello world!'
      },
      {
        id: '2',
        thumbnail: {
          path: require('@/assets/images/im1.jpg'),
          height: 187
        },
        title: 'Another Article',
        date: 'May. 12, 2018',
        placeName: 'Home',
        intro: '#2 Hello world!'
      },
      {
        id: '3',
        thumbnail: {
          path: require('@/assets/images/im2.jpg'),
          height: 187
        },
        title: 'An Article',
        date: 'May. 12, 2018',
        placeName: 'Home',
        intro: '#3 Hello world!'
      },
      {
        id: '4',
        thumbnail: {
          path: require('@/assets/images/im3.jpg'),
          height: 187
        },
        title: 'An Article',
        date: 'May. 12, 2018',
        placeName: 'Home',
        intro: '#4 Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.'
      },
      {
        id: '5',
        thumbnail: {
          path: require('@/assets/images/im4.jpg'),
          height: 464
        },
        title: 'An Article',
        date: 'May. 12, 2018',
        placeName: 'Home',
        intro: '#5 Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.'
      },
      {
        id: '6',
        thumbnail: {
          path: require('@/assets/images/im2.jpg'),
          height: 187
        },
        title: 'An Article',
        date: 'May. 12, 2018',
        placeName: 'Home',
        intro: '#6 Hello world!'
      },
      {
        id: '7',
        thumbnail: {
          path: require('@/assets/images/im1.jpg'),
          height: 187
        },
        title: 'Another Article',
        date: 'May. 12, 2018',
        placeName: 'Home',
        intro: '#7 Hello world!'
      }
    ]

    this.rearrangeArticles(this.articles)

    window.addEventListener('resize', () => this.rearrangeArticles(this.articles))
  },

  methods: {
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
            const textHeight = this.$refs.column[index].scrollHeight
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
