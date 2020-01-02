<template>
  <div class="columns is-desktop">
    <div class="column is-half is-offset-one-quarter">
      <h1 class="title is-2">Sign In</h1>
      <b-message v-if="message.show" :type="message.type" aria-close-label="Close message">
        {{message.content}}
      </b-message>


      <form @submit.prevent="onSubmit">
        <b-field v-for="field, key, id in formFields" :id="key" :key="key" :label="key | camel-to-space" :type="formFields[key].classType" :message="formFields[key].message">
          <b-input v-model="formFields[key].value" :type="formFields[key].type" :message="formFields[key].message" @focus="clearErrors" ></b-input>
        </b-field>
        <div class="buttons">
          <b-button native-type="submit" type="is-primary">Sign in</b-button>
        </div>
      </form>
    </div>
  </div>
</template>

<script>
import formErrorHandlingMixin from '../mixins/formErrorHandlingMixin'

export default {
  name: 'signIn',
  mixins: [formErrorHandlingMixin],
  data: function () {
    return {
      formFields: {
        email: { value: '', type: 'email', message: null, classType: null},
        password: { value: '', type: 'password', message: null, classType: null},
      },
      message: {
        show: false,
        type: null,
        content: null
      }
    }
  },
  methods: {
    onSubmit () {
      if(this.requiredFieldsErrors(['email', 'password'])) {
        return
      };
      const formData = {
        email: this.formFields.email.value,
        password: this.formFields.password.value
      }

      // console.log(formData)
      this.$store.dispatch('authenticateUser', formData).then(() => {
        this.$router.replace({ path: '/admin/dashboard' })
      }).catch(error => {
        this.message.show = true
        this.message.type = 'is-danger'
        this.message.content = 'Oops, we cannot authenticate your credentials'
      })
    }
  }
}
</script>

<style scoped >
p {
  font-size: 2em;
  text-align: center;
}
</style>
