<template>
  <div class="columns is-desktop">
    <div class="column is-half is-offset-one-quarter">
      <h1 class="title is-2">Create Account</h1>
      <b-message v-if="message.show" :type="message.type" aria-close-label="Close message">
        {{message.content}}
      </b-message>
      <form @submit.prevent="onSubmit">
        <b-field v-for="field, key, id in formFields" :id="key" :key="key" :label="key | camel-to-space" :type="formFields[key].classType" :message="formFields[key].message">
          <b-input v-model="formFields[key].value" :type="formFields[key].type"></b-input>
        </b-field>

        <div class="buttons">
          <b-button native-type="submit" type="is-primary">Create</b-button>
        </div>
      </form>
    </div>
  </div>
</template>

<script>
import axios from 'axios'
import formErrorHandlingMixin from '../mixins/formErrorHandlingMixin'

export default {
  name: 'registration',
  mixins: [formErrorHandlingMixin],
  data () {
    return {
      formFields: {
        name: { value: '', type: 'name', message: null, classType: null},
        email: { value: '', type: 'email', message: null, classType: null},
        password: { value: '', type: 'password', message: null, classType: null},
        passwordConfirmation: { value: '', type: 'password', message: null, classType: null},
      }
    }
  },
  methods: {
     onSubmit () {
      this.clearErrors();
      if(this.requiredFieldsErrors(['email', 'password', 'passwordConfirmation'])) {
        return
      };
      if(!this.passwordCheck()) {
        return
      };
      const formData = {
        name: this.formFields.name.value,
        email: this.formFields.email.value,
        password: this.formFields.password.value,
        password_confirmation: this.formFields.passwordConfirmation.value
      }

      // console.log(formData)
      // not using store method
      axios.post('http://localhost:5000/admin/sign_up', {user: formData })
        .then( res => {
          localStorage.setItem('auth_token', res.data.body.token)
          this.$store.commit('setToken', res.data.body.token);
          console.log(res)
          this.$router.replace({ path: '/admin/dashboard' })
        })
        .catch( error => {
          console.log(error)
          this.showFieldErrors(error)
        })
    }
  }
}
</script>

<style scoped >

</style>
