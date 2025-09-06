import { Request, Response, NextFunction } from 'express';
import Joi from 'joi';

const paymentSchema = Joi.object({
  amount: Joi.number().positive().required(),
  description: Joi.string().min(1).max(500).required()
});

export const validatePayment = (req: Request, res: Response, next: NextFunction) => {
  const { error } = paymentSchema.validate(req.body);
  
  if (error) {
    return res.status(400).json({
      error: 'Validation error',
      details: error.details.map(detail => detail.message)
    });
  }

  // Check for idempotency key in headers
  const idempotencyKey = req.headers['x-idempotency-key'] as string;
  
  if (!idempotencyKey) {
    return res.status(400).json({
      error: 'X-Idempotency-Key header is required'
    });
  }

  req.body.idempotencyKey = idempotencyKey;
  next();
};
