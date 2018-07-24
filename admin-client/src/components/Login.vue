<template>
  <div id="login">
    <b-container>
      <img :src="require('@/assets/captain-cap.png')" class="logo"/>
      <h3 class="title">Captain's Cabin</h3>
      <b-row class="justify-content-md-center">
        <b-col md="3">
          <b-form-group>
            <b-form-input v-model="username" placeholder="Username"/>
          </b-form-group>
        </b-col>
      </b-row>

      <b-row class="justify-content-md-center">
        <b-col md="3">
          <b-form-group>
              <b-form-input v-model="password" placeholder="Password" :type="passwordType" @keyup.enter.native="verify"/>
          </b-form-group>
        </b-col>
      </b-row>

      <b-btn @click="verify">Login</b-btn>
      <div class="error" v-if="hasError">Incorrect username and/or password!</div>
    </b-container>
  </div>
</template>

<script>
import UserService from '@/services/UserService'

export default {
  data() {
    return {
      username: '',
      password: '',
      passwordType: 'password',
      hasError: false
    }
  },
  methods: {
    async verify() {
      try {
        let data = (await UserService.post({ username: this.username, password: this.password })).data
        if (data.jwt) {
          this.hasError = false
          this.$emit('authenticated', true)
          localStorage.token = data.jwt
          this.$router.replace('/home')
        }
      } catch (e) {
        console.log(e)
        this.hasError = true
        this.username = ''
        this.password = ''
        delete localStorage.token
      }
    }
  }
}
</script>

<style scoped>
#login {
  text-align: center;
}

.logo {
  width: 120px;
}

.title {
  margin: 0 auto 30px;
}

.error {
  margin-top: 10px;
  color: #ff0000;
}
</style>
