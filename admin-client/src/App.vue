<template>
  <div id="app">
    <div class="menu-container" v-if="authenticated">
      <b-nav to="/login" vertical class="d-none d-md-block col-md-3 col-lg-2 pt-1 bg-light sidebar">
        <b-nav-item><font-awesome-icon class="icon" icon="file-image" fixed-width />Articles</b-nav-item>
        <b-nav-item><font-awesome-icon class="icon" icon="map-marked-alt" fixed-width />Places</b-nav-item>
        <b-nav-item to="/tags"><font-awesome-icon class="icon" icon="tag" fixed-width />Tags</b-nav-item>
      </b-nav>
    </div>

    <div class="content-container col-12 col-md-9 ml-sm-auto col-lg-10 pt-3">
      <router-view @authenticated="setAuthenticated"/>
    </div>
  </div>
</template>

<script>
export default {
  name: 'App',

  data() {
    return {
      authenticated: false
    }
  },

  mounted() {
    if (!this.authenticated) {
      this.$router.replace('/login')
    }
  },

  methods: {
    setAuthenticated(status) {
      this.authenticated = status
    }
  }
}
</script>

<style scoped>
.sidebar {
  position: fixed;
  top: 0;
  bottom: 0;
  left: 0;
  box-shadow: inset -2px 0 6px 0 rgba(0.5, 0.5, 0.5, 0.1);
}

.icon {
  margin-right: 10px;
}
</style>
