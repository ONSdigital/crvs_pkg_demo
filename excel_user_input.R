##### General workbook info ----------------------------------------------------

excel_input <- list(
  cover_sheet_source = "spreadsheet_input/cover_sheet.txt",
  country = "Country",
  publication_date = "25 December 2026",
  publication_copyright_yr = 2026,
  birth_title = "Births Vital Statistics in",
  data_source = "Organisation producing the statistics",
  contact_email = "email_me@mail.com",
  contact_phone = "+123-4567-8901",
  contents_file = "spreadsheet_input/contents.txt",
  notes_file = "spreadsheet_input/notes.txt"
)

cover_sheet_cfg <- list(
  cover_sheet_links_rows = c(5, 8),
  cover_sheet_links = c(
    "https://www.link_to_report.com",
    paste0("mailto:", excel_input$contact_email)
  )
)

notes_sheet_cfg <- list(
  notes_sheet_links_rows = c(1),
  notes_sheet_links = c("https://www.link_to_note1.com")
)

notes_per_table <- list(
  notes_tab4_2 = "[note 1]",
  notes_tab4_3 = "[note 1]",
  notes_tab4_4 = "[note 1]",
  notes_tab4_5_6 = "[note 1]",
  notes_tab4_7 = "[note 1]",
  notes_tab4_8 = "[note 1]",
  notes_tab4_9 = "[note 1]"
)

birth_excel_title <- paste0(
  excel_input$birth_title, " ",
  excel_input$country, ", ",
  max(birth_years)
)

birth_table_headings <- list(
  table_4_2 = "Live births by place of birth and sex,",
  table_4_3 =
    "Live births by place of birth and place of usual residence,",
  table_4_4 =
    "Live births and stillbirths by grouped mothers age,",
  table_4_5 =
    "Live births occurring in urban place of residence and marital status,",
  table_4_6 =
    "Live births occurring in rural place of residence and marital status,",
  table_4_5_6 =
    "Live births by urban or rural place of residence and marital status,",
  table_4_7 =
    paste("Live births by place of birth, place of birth type and birth",
          "attendant,"),
  table_4_8 = "Crude birth rate by place of residence,",
  table_4_9 =
    paste("Age-specific fertility rate of the mother by place of usual",
          "residence,")
)
