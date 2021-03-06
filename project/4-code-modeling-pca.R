# @head: MECAI | MAI5024
# @auth: Andre Perez
# @mail: andre.marcos.perez@usp.br

# ------------------------------------------------------------------------------
# -- Clean ---------------------------------------------------------------------
# ------------------------------------------------------------------------------

rm(list=ls())
cat("\014")

# ------------------------------------------------------------------------------
# -- Variable ------------------------------------------------------------------
# ------------------------------------------------------------------------------

# -- Environment

PATH.INPUT  <- "dataset"
FILE.INPUT  <- "kaggle-preprocessing.csv"

# -- Script

# ------------------------------------------------------------------------------
# -- Library -------------------------------------------------------------------
# ------------------------------------------------------------------------------

if (!require("caret")) {
  install.packages("caret");
  library("caret");
}

# ------------------------------------------------------------------------------
# -- Functions -----------------------------------------------------------------
# ------------------------------------------------------------------------------

# ------------------------------------------------------------------------------
# -- Main ----------------------------------------------------------------------
# ------------------------------------------------------------------------------

data <- read.csv(file.path(PATH.INPUT, FILE.INPUT), na.strings=c("NA"), encoding="UTF-8");

# ----------------------------------------
# -- Modeling ----------------------------
# ----------------------------------------

data$Job <- as.factor(data$Job);

# train control

train.ctrl <- trainControl(
  method = "cv",
  number = 10,
  verboseIter = TRUE
);

# model

print(" - Generalized Linear Model")
model.glm <- train(Job ~ ., data, method="glm", trControl=train.ctrl);
model.glm.cm <- confusionMatrix(predict(model.glm, data), data$Job);

# ------------------------------------------------------------------------------
# -- Clean ---------------------------------------------------------------------
# ------------------------------------------------------------------------------

rm(list = c("FILE.INPUT", "PATH.INPUT"));
rm(list = c("train.ctrl"));

# ------------------------------------------------------------------------------
# -- Done ---------------------------------------------------------------------
# ------------------------------------------------------------------------------

print("# ---------------------------------------------------------------------")
print("# -- Done -------------------------------------------------------------")
print("# ---------------------------------------------------------------------")