React     = require 'react'

# Components
{ Link }  = require 'react-router'

# Stores
store     = require '../stores/posts'

# Actions
{
  getPosts
}         = require '../actions'

module.exports = class Application extends React.Component
  constructor : (props, context) ->
    super props, context
    @state = props.route.data

  @fetch: ->
    do getPosts

  componentDidMount : ->
    @unsubscribe = store.listen (data) -> @setState data

  componentWillUnmount: ->
    do @unsubscribe

  render  : ->
    <div>
      <Link to = '/'><h1>React blog</h1></Link>
      {
        { posts } = @state

        <ul>{
          <li key = {id}>
            <Link to={ "/#{id}" }>{ post }</Link>
          </li> for post, id in posts
        }</ul> if posts?
      }
      { @props.children or <p>Please choose a post about a cat.</p> }
    </div>
