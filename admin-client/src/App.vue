<template>
  <div id="app" class="tb-page-container d-flex flex-row">
    <div class="tb-menu d-none d-md-block col-md-3 col-lg-2 bg-light" v-if="authenticated">
      <ul class="nav flex-column">
        <li class="nav-item">
          <font-awesome-icon class="tb-menu__nav-item-icon" icon="file-image" fixed-width/>Articles
        </li>
        <li class="nav-item">
          <font-awesome-icon class="tb-menu__nav-item-icon" icon="map-marked-alt" fixed-width/>Places
        </li>
        <li class="nav-item">
          <font-awesome-icon class="tb-menu__nav-item-icon" icon="tag" fixed-width/>Tags
        </li>
      </ul>
    </div>

    <div class="tb-content" :class="authenticated ? ['ml-md-auto', 'col-md-9', 'col-lg-10'] : ['col-12']">
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
.tb-menu {
  position: fixed;
  top: 0;
  bottom: 0;
  left: 0;
  padding-top: 1em;
  box-shadow: inset -2px 0 6px 0 rgba(0.5, 0.5, 0.5, 0.1);
}

.tb-menu__nav-item-icon {
  margin-right: 10px;
}

.tb-content {
  padding-top: 1em;
}
</style>
