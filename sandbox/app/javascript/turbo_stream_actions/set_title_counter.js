export default function () {
  const count = this.getAttribute('count') || 0;
  const divider = this.getAttribute('divider') || '-';
  const title = document.title;
  const baseTitle = title.includes(divider) ? title.split(divider).pop().trim() : title

  document.title = count > 0 ? `${count} ${divider} ${baseTitle}` : baseTitle;
}
