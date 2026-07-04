import { apiInitializer } from "discourse/lib/api";

export default apiInitializer((api) => {
  // This initializer ensures our custom date component is properly registered
  // and used for post date formatting throughout the Discourse interface.

  // The component automatically replaces the default post date display
  // based on the theme settings configuration.
});
