<template style="text-align=center">
  <div class="h-100" style="margin-left:auto; margin-right:auto">

    <div class="card d-inline-block text-start">

      <div class="card-header">
        <h3 class="card-title">Profile</h3>
      </div>

      <div class="card-body">

        <h2>{{ fullname }}</h2>
        <h4 class="text-secondary">{{ email }}</h4>
        <hr class="text-secondary"/>

        <ChangePassword v-if="changingPassword" @close="changingPassword = false" />

        <button v-else class="btn btn-primary" @click="changingPassword = true">Change Password</button>

      </div>

    </div>

  </div>
</template>

<script lang="ts">
import { defineComponent } from 'vue'

import Center from '@/components/misc/Center.vue'
import ChangePassword from '@/components/profile/ChangePassword.vue';

export default defineComponent({
  name: 'Profile',
  components: {
    Center,
    ChangePassword
  },
  created() {
    if(!this.$store.state.auth.isLoggedIn) {
      this.$router.push('/login');
    }
  },
  data() {
    return {
      fullname: this.$store.getters.userFullname,
      email: this.$store.getters.userEmail, 
      changingPassword: false
    }
  }
})
</script>

<style scoped>
  .card {
    min-width: 400px;
  }
</style>
