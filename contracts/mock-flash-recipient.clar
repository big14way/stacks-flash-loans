(use-trait ft-trait 'SP3FBR2AGK5H9QBDH3EEN6DF8EK8JY7RX8QJ5SVTE.sip-010-trait-ft-standard.sip-010-trait)

(impl-trait .flashloans-trait-v4.stx-flasher)
(impl-trait .flashloans-trait-v4.sip010-flasher)

;; In Clarity 4, we get the contract principal differently
(define-constant THIS_CONTRACT tx-sender)
(define-constant OWNER tx-sender)

;; Clarity 4 Features
;; Get contract hash - Clarity 4 feature
(define-read-only (get-contract-hash)
  (ok (contract-hash? .mock-flash-recipient-v4))
)

;; Verify contract integrity - Clarity 4 feature
(define-read-only (verify-contract-integrity)
  (match (contract-hash? .mock-flash-recipient-v4)
    hash-value (ok true)
    error-val (ok false)
  )
)

;; Get current block height - Clarity 4 feature
(define-read-only (get-current-block-height)
  (ok stacks-block-height)
)

(define-constant ERR_NOT_OWNER (err u100))
(define-constant ERR_NOT_INITIALIZED (err u101))
(define-constant ERR_ALREADY_INITIALIZED (err u102))
(define-constant ERR_FAILED_ACTION (err u103))
(define-constant ERR_FAILED_REPAYMENT (err u104))
(define-constant ERR_NOT_FLASHER (err u105))

(define-data-var FLASHER principal tx-sender)
(define-data-var INITIALIZED bool false)

(define-public (set-flashloans (flashloans principal))
    (begin
        ;; Ensure only the owner can initialize the contract
        (asserts! (is-eq tx-sender OWNER) ERR_NOT_OWNER)
        ;; Ensure the contract is not already initialized
        (asserts! (not (var-get INITIALIZED)) ERR_ALREADY_INITIALIZED)
        (var-set FLASHER flashloans)
        (var-set INITIALIZED true)
        (ok true)
    )
)

(define-public (on-stx-flash
        (amount uint)
        (return-amount uint)
    )
    (begin
        ;; Ensure the contract is initialized
        (asserts! (var-get INITIALIZED) ERR_NOT_INITIALIZED)
        ;; Ensure the caller is the flash loan protocol
        (asserts! (is-eq contract-caller (var-get FLASHER)) ERR_NOT_FLASHER)

        ;; Dummy function to simulate a profitable action
        (unwrap! (do-something) ERR_FAILED_ACTION)

        ;; Repay the flash loan with interest
        ;; Using as-contract? (Clarity 4 feature) with STX allowances for secure transfers
        (unwrap!
            (match (as-contract? ((with-stx return-amount))
                (try! (stx-transfer? return-amount THIS_CONTRACT (var-get FLASHER))))
                success (ok true)
                error ERR_FAILED_REPAYMENT
            )
            ERR_FAILED_REPAYMENT
        )
        (ok true)
    )
)

(define-public (on-sip010-flash
        (token <ft-trait>)
        (amount uint)
        (return-amount uint)
    )
    (begin
        ;; Ensure the contract is initialized
        (asserts! (var-get INITIALIZED) ERR_NOT_INITIALIZED)
        ;; Ensure the caller is the flash loan protocol
        (asserts! (is-eq contract-caller (var-get FLASHER)) ERR_NOT_FLASHER)

        ;; Dummy function to simulate a profitable action
        (unwrap! (do-something) ERR_FAILED_ACTION)

        ;; Repay the flash loan with interest
        ;; Using as-contract? (Clarity 4 feature) with asset allowances for secure token transfers
        (unwrap!
            (match (as-contract? ((with-all-assets-unsafe))
                (try! (contract-call? token transfer return-amount THIS_CONTRACT
                    (var-get FLASHER) none
                )))
                success (ok true)
                error ERR_FAILED_REPAYMENT
            )
            ERR_FAILED_REPAYMENT
        )
        (ok true)
    )
)

;; Dummy function to simulate a profitable action
(define-private (do-something)
    (ok true)
)
