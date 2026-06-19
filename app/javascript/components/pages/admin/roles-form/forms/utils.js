// Copyright (c) 2014 - 2023 UNICEF. All rights reserved.

import startCase from "lodash/startCase";

const translatedLocationType = (value, i18n) => {
  const key = `location.base_types.${value.replaceAll("_", "-")}`;
  const translation = i18n?.t?.(key);

  return translation && translation !== key ? translation : startCase(value);
};

const buildLabel = (element, i18n, resource, approvalsLabel, type) => {
  const approvalLabel = (approvalsLabel.size > 0 ? [...approvalsLabel.get("default").keys()] : []).filter(approval =>
    element.includes(approval)
  );

  const label =
    approvalsLabel.size > 0 ? approvalsLabel.getIn(["default", approvalLabel[approvalLabel.length - 1]]) : "";

  return i18n.t(`permissions.resource.${resource}.actions.${element}.${type}`, {
    approval_label: label
  });
};

export const buildPermissionOptions = (elements = [], i18n, resource, approvalsLabel = {}) =>
  elements.map(element => ({
    id: element,
    display_text: buildLabel(element, i18n, resource, approvalsLabel, "label"),
    tooltip: buildLabel(element, i18n, resource, approvalsLabel, "explanation")
  }));

export const buildAdminLevelSelect = (adminLevelMap, i18n) => {
  return adminLevelMap.entrySeq().reduce((acc, [id, text = []]) => {
    return [
      ...acc,
      {
        id: parseInt(id, 10),
        display_text: text.map(value => translatedLocationType(value, i18n)).join(", ")
      }
    ];
  }, []);
};
