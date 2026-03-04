import Component from "@glimmer/component";
import { on } from "@ember/modifier";
import { action } from "@ember/object";
import { service } from "@ember/service";
import ShareTopicModal from "discourse/components/modal/share-topic";
import rawDate from "discourse/helpers/raw-date";
import concatClass from "discourse/helpers/concat-class";
import { and } from "discourse/truth-helpers";
import { i18n } from "discourse-i18n";

export default class PostMetaDataFullDate extends Component {
  @service modal;

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
        {{rawDate @post.displayDate}}
      </a>
    </div>
  </template>
}
