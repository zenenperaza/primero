// Copyright (c) 2014 - 2023 UNICEF. All rights reserved.

import { Dialog, DialogActions, DialogContent, DialogTitle, IconButton, Tab, Tabs } from "@mui/material";
import AddIcon from "@mui/icons-material/Add";
import CloseIcon from "@mui/icons-material/Close";
import { push } from "connected-react-router";
import PropTypes from "prop-types";
import { useEffect, useState } from "react";
import { useForm, useWatch } from "react-hook-form";
import { batch, useDispatch } from "react-redux";

import { useMemoizedSelector } from "../../../libs";
import ActionButton from "../../action-button";
import { ACTION_BUTTON_TYPES } from "../../action-button/constants";
import { submitHandler, whichFormMode } from "../../form";
import FormSection from "../../form/components/form-section";
import { FORM_MODE_NEW } from "../../form/constants";
import { useI18n } from "../../i18n";
import { applyFilters } from "../../index-filters";
import { getRecordsData } from "../../index-table";
import { enqueueSnackbar } from "../../notifier";
import { SEARCH_OR_CREATE_FILTERS } from "../constants";
import PhoneticHelpText from "../../index-filters/components/phonetic-help-text";
import { searchTitleI18nKey } from "../../index-filters/components/search-box/utils";
import SearchButton from "../../record-creation-flow/components/search-button";
import { setRedirectedToCreateNewRecord } from "../../record-form/action-creators";

import { FORM_ID, NAME, PHONETIC_FIELD_NAME } from "./constants";
import { searchForm } from "./forms";
import css from "./styles.css";

const SEARCH_TABS = {
  id: "id",
  name: "name",
  phone: "phone"
};

function Component({ moduleUniqueId, open = false, recordType, setOpen }) {
  const formMode = whichFormMode(FORM_MODE_NEW);

  const dispatch = useDispatch();
  const i18n = useI18n();

  const methods = useForm({ defaultValues: {} });
  const {
    formState: { dirtyFields, isSubmitted },
    getValues,
    handleSubmit,
    control,
    setValue,
    register
  } = methods;

  const [selectedSearchTab, setSelectedSearchTab] = useState(SEARCH_TABS.id);
  const phonetic = useWatch({ control, name: PHONETIC_FIELD_NAME, defaultValue: false });
  const record = useMemoizedSelector(state => getRecordsData(state, recordType));
  const searchTitle = i18n.t(searchTitleI18nKey(phonetic));
  const searchHelpText = i18n.t("case.search_helper_text");

  const onSubmit = data => {
    submitHandler({
      data,
      dispatch,
      dirtyFields,
      formMode,
      i18n,
      initialValues: {},
      onSubmit: formData => {
        dispatch(
          applyFilters({
            recordType,
            data: { ...SEARCH_OR_CREATE_FILTERS, ...formData, id_search: true }
          })
        );
      }
    });
  };

  const handleClose = () => {
    setOpen(false);
  };

  const handleCreateNewCase = () => {
    dispatch(push(`/${recordType}/${moduleUniqueId}/new`));
  };

  const redirectToNewCase = () => {
    batch(() => {
      dispatch(setRedirectedToCreateNewRecord(true));
      dispatch(push(`/${recordType}/${moduleUniqueId}/new`));
    });
  };

  const handleSearchTabChange = (_event, value) => {
    setSelectedSearchTab(value);
    setValue(PHONETIC_FIELD_NAME, value === SEARCH_TABS.name, { shouldDirty: true });
  };

  useEffect(() => {
    const hasData = Boolean(record?.size);

    if (open && isSubmitted) {
      if (hasData) {
        setOpen(false);
      } else {
        const { query } = getValues();

        setOpen(false);
        redirectToNewCase();
        dispatch(enqueueSnackbar(i18n.t("case.id_search_no_results", { search_query: query }), "error"));
      }
    }
  }, [record]);

  useEffect(() => {
    register(PHONETIC_FIELD_NAME);
  }, [register]);

  useEffect(() => {
    if (open) {
      setSelectedSearchTab(SEARCH_TABS.id);
      setValue(PHONETIC_FIELD_NAME, false);
    }
  }, [open]);

  return (
    <Dialog open={open} maxWidth="md" fullWidth data-testid="CreateRecordDialog">
      <DialogTitle>
        <div className={css.title}>
          <div className={css.newCase}>{i18n.t("case.create_new_case")}</div>
          <div className={css.close}>
            <IconButton size="large" onClick={handleClose}>
              <CloseIcon />
            </IconButton>
          </div>
        </div>
      </DialogTitle>
      <DialogContent>
        <p className={css.helper}>{searchHelpText}</p>
        <form id={FORM_ID} onSubmit={handleSubmit(onSubmit)} className={css.searchForm}>
          <div className={css.tabsRow}>
            <span className={css.searchBy}>{i18n.t("case.search_by")}</span>
            <Tabs value={selectedSearchTab} onChange={handleSearchTabChange} className={css.tabs}>
              <Tab value={SEARCH_TABS.id} label="ID Fields" />
              <Tab value={SEARCH_TABS.name} label="Name Fields" />
              <Tab value={SEARCH_TABS.phone} label="Phone No." />
            </Tabs>
          </div>
          {searchForm(searchTitle, searchHelpText).map(formSection => (
            <FormSection
              formSection={formSection}
              key={formSection.unique_id}
              formMode={formMode}
              formMethods={methods}
            />
          ))}
          <div className={css.search}>
            <div className={css.searchButton}>
              <SearchButton formId={FORM_ID} />
            </div>
          </div>
          {phonetic && <PhoneticHelpText />}
        </form>
      </DialogContent>
      <DialogActions>
        <div className={css.actions}>
          <div className={css.createNewCase}>
            <ActionButton
              icon={<AddIcon />}
              text="case.skip_and_create"
              type={ACTION_BUTTON_TYPES.default}
              rest={{ onClick: handleCreateNewCase }}
              size="large"
            />
          </div>
        </div>
      </DialogActions>
    </Dialog>
  );
}

Component.displayName = NAME;

Component.propTypes = {
  moduleUniqueId: PropTypes.string.isRequired,
  open: PropTypes.bool,
  recordType: PropTypes.string.isRequired,
  setOpen: PropTypes.func.isRequired
};

export default Component;
