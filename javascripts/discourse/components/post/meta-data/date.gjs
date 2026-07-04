import Component from "@glimmer/component";
import { on } from "@ember/modifier";
import { action } from "@ember/object";
import { service } from "@ember/service";
import { inject as plugin } from "@ember/service";
import ShareTopicModal from "discourse/components/modal/share-topic";
import rawDate from "discourse/helpers/raw-date";
import formatDate from "discourse/helpers/format-date";
import concatClass from "discourse/helpers/concat-class";
import { and } from "discourse/truth-helpers";
import { i18n } from "discourse-i18n";
import { htmlSafe } from "@ember/template";

export default class PostMetaDataFullDate extends Component {
  @service modal;
  @service siteSettings;
  @plugin("discourse-post-date-format") themeSettings;

  get formattedDate() {
    // If date display is disabled, return empty string
    if (this.themeSettings.date_format_option === "none") {
      return htmlSafe("");
    }

    const postDate = this.args.post.displayDate;

    // If we can't get a valid date, fallback to rawDate
    if (!postDate) {
      return rawDate(this.args.post.displayDate);
    }

    // Handle different format options
    switch (this.themeSettings.date_format_option) {
      case "full":
        // Use Discourse's default full date format
        return rawDate(this.args.post.displayDate);

      case "short":
        // Use a shorter format
        return formatDate(postDate, { format: "ll" });

      case "custom":
        // Use custom format from settings
        return formatDate(postDate, { format: this.themeSettings.custom_date_format });

      default:
        // Fallback to rawDate
        return rawDate(this.args.post.displayDate);
    }
  }

  get shouldDisplayDate() {
    return this.themeSettings.date_format_option !== "none";
  }

  @action
  openShareModal(event) {
    event.preventDefault();

    const post = this.args.post;
    const topic = post.topic;

    this.modal.show(ShareTopicModal, {
      model: {
        category: topic.category,
        topic,
        post,
      },
    });
  }

  <template>
    {{#if this.shouldDisplayDate}}
      <div class="post-info post-date">
        <a
          class={{concatClass
            "post-date"
            (if (and @post.wiki @post.last_wiki_edit) "last-wiki-edit")
          }}
          href={{@post.shareUrl}}
          title={{i18n "post.sr_date"}}
          {{on "click" this.openShareModal}}
        >
          {{this.formattedDate}}
        </a>
      </div>
    {{/if}}
  </template>
}
