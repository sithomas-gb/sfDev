import { LightningElement, api } from 'lwc';

export default class IntegrationStatusViewerWrapper extends LightningElement {
  @api cardTitle = 'Card Title';
  @api cardTitleColor = '#000000';
  @api cardIcon = 'standard:events';
  @api buttonIcon = 'utility:sync';
  @api intervalTime = 1000;
  @api toastMessage = 'Success!';
  @api originalStepsWrapper = 'Step 1|utility:success,Step 2|utility:success,Step 3|utility:success';

  intervalId;
  steps = [];

  showLocalToast = false;
  toastMessageValue = '';

  connectedCallback() {
    this.setSteps();
  }

  setSteps() {
    if (!this.originalStepsWrapper) {
      this.steps = [];
      return;
    }

    const rawSteps = this.originalStepsWrapper.split(',');
    this.steps = rawSteps.map((s) => {
      const [label, icon] = s.split('|');
      const trimmedIcon = icon?.trim() || 'utility:success';

      return {
        text: label?.trim() || 'Step',
        originalIcon: trimmedIcon,       // ← save original
        iconName: trimmedIcon,           // ← display original until complete
        isActive: false,
        isComplete: false,
        variant: '',
        itemClass: 'slds-progress__item',
        markerClass: 'slds-progress__marker slds-progress__marker_icon'
      };
    });
  }

  handleStart() {
    if (this.intervalId) {
      clearInterval(this.intervalId);
      this.setSteps();
      this.intervalId = null;
      return;
    }

    let activeStepIndex = 0;
    this.steps[activeStepIndex].isActive = true;
    this.steps[activeStepIndex].itemClass = 'slds-progress__item slds-is-active';
    this.steps[activeStepIndex].markerClass = 'slds-progress__marker';

    this.intervalId = setInterval(() => {
      const current = this.steps[activeStepIndex];
      if (current) {
        current.isActive = false;
        current.isComplete = true;
        current.variant = 'success';
        current.iconName = 'utility:success'; // ← only override here
        current.itemClass = 'slds-progress__item';
        current.markerClass = 'slds-progress__marker';
      }

      const next = this.steps[activeStepIndex + 1];
      if (next) {
        activeStepIndex++;
        next.isActive = true;
        next.itemClass = 'slds-progress__item slds-is-active';
        next.markerClass = 'slds-progress__marker';
      } else {
        clearInterval(this.intervalId);
        this.intervalId = null;

        if (this.toastMessage) {
          this.handleComplete();
        }
      }

      this.steps = [...this.steps];
    }, parseInt(this.intervalTime, 10));
  }

  handleComplete() {
    this.toastMessageValue = this.toastMessage;
    this.showLocalToast = true;

    setTimeout(() => {
      this.showLocalToast = false;
    }, 3000);
  }

  get computedTitleStyle() {
    return `color: ${this.cardTitleColor || '#000000'}`;
  }

  get stepCount() {
    return this.steps?.length || 0;
  }
}